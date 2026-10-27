#!/usr/bin/env npx tsx

/**
 * Claude Code statusline
 *
 * Displays:
 *   Provider: model - $cost - cache: $saved | vX.Y.Z | branch | [progress] XX% (used / total)
 *
 * Setup: Add to your ~/.claude/settings.json:
 * {
 *   "statusLine": {
 *     "type": "command",
 *     "command": "/path/to/statusline.sh"
 *   }
 * }
 *
 * Requires: ANTHROPIC_AUTH_TOKEN or ANTHROPIC_API_KEY set to your OpenRouter API key
 */

import { execSync } from 'node:child_process';
import { existsSync, readFileSync, writeFileSync } from 'node:fs';

interface StatuslineInput {
  session_id: string;
  session_name?: string;
  transcript_path: string;
  cwd?: string;
  version?: string;
  model?: {
    id: string;
    display_name: string;
  };
  workspace?: {
    current_dir: string;
    project_dir?: string;
    repo?: {
      host: string;
      owner: string;
      name: string;
    };
  };
  context_window?: {
    total_input_tokens?: number;
    context_window_size?: number;
    used_percentage?: number;
    remaining_percentage?: number;
    current_usage?: {
      input_tokens: number;
      output_tokens: number;
      cache_creation_input_tokens: number;
      cache_read_input_tokens: number;
    } | null;
  };
}

interface GenerationData {
  total_cost: number;
  cache_discount: number | null;
  provider_name: string;
  model: string;
}

interface State {
  seen_ids: string[];
  total_cost: number;
  total_cache_discount: number;
  last_provider: string;
  last_model: string;
}

async function fetchGeneration(id: string, apiKey: string): Promise<GenerationData | null> {
  try {
    const res = await fetch(`https://openrouter.ai/api/v1/generation?id=${id}`, {
      headers: {
        Authorization: `Bearer ${apiKey}`,
      },
    });

    if (!res.ok) {
      return null;
    }

    const json = await res.json();
    const data = json?.data;

    if (!data || typeof data.total_cost !== 'number') {
      return null;
    }

    return data;
  } catch {
    return null;
  }
}

function extractGenerationIds(transcriptPath: string): string[] {
  try {
    const content = readFileSync(transcriptPath, 'utf-8');
    const ids: string[] = [];

    for (const line of content.split('\n')) {
      if (!line.trim()) {
        continue;
      }
      try {
        const entry = JSON.parse(line);
        const messageId = entry?.message?.id;
        if (typeof messageId === 'string' && messageId.startsWith('gen-')) {
          ids.push(messageId);
        }
      } catch {
        // Skip malformed lines
      }
    }

    return [...new Set(ids)];
  } catch {
    return [];
  }
}

function loadState(statePath: string): State {
  const defaultState: State = {
    seen_ids: [],
    total_cost: 0,
    total_cache_discount: 0,
    last_provider: '',
    last_model: '',
  };

  if (!existsSync(statePath)) {
    return defaultState;
  }

  try {
    const content = readFileSync(statePath, 'utf-8');
    if (!content.trim()) {
      return defaultState;
    }

    const parsed = JSON.parse(content);

    // Validate state shape
    if (!Array.isArray(parsed.seen_ids)) {
      return defaultState;
    }

    return {
      seen_ids: parsed.seen_ids,
      total_cost: typeof parsed.total_cost === 'number' ? parsed.total_cost : 0,
      total_cache_discount:
        typeof parsed.total_cache_discount === 'number' ? parsed.total_cache_discount : 0,
      last_provider: typeof parsed.last_provider === 'string' ? parsed.last_provider : '',
      last_model: typeof parsed.last_model === 'string' ? parsed.last_model : '',
    };
  } catch {
    return defaultState;
  }
}

function saveState(statePath: string, state: State): void {
  writeFileSync(statePath, JSON.stringify(state, null, 2));
}

function shortModelName(model: string): string {
  return model.replace(/^[^/]+\//, '').replace(/-\d{8}$/, '');
}

/** Format numbers with K/M suffixes for readability */
function formatNumber(n: number): string {
  if (n >= 1_000_000) return `${(n / 1_000_000).toFixed(1)}M`;
  if (n >= 1_000) return `${(n / 1_000).toFixed(1)}K`;
  return n.toString();
}

/** Build a visual progress bar (width=10) */
function progressBar(pct: number): string {
  const clamped = Math.max(0, Math.min(100, pct));
  const filled = Math.round((clamped / 100) * 10);
  const empty = 10 - filled;
  // Blue for filled portion (visible on both light and dark backgrounds)
  const fillColor = '\x1b[34m';
  const reset = '\x1b[0m';
  return `[${fillColor}${'█'.repeat(filled)}${reset}${'░'.repeat(empty)}]`;
}

/** Get the current git branch name, or fall back to the folder name */
function getBranchOrFolder(cwd: string): string {
  try {
    const branch = execSync('git --no-optional-locks branch --show-current 2>/dev/null', { cwd, encoding: 'utf-8' }).trim();
    if (branch) return branch;
    const hash = execSync('git --no-optional-locks rev-parse --short HEAD 2>/dev/null', { cwd, encoding: 'utf-8' }).trim();
    if (hash) return `detached@${hash}`;
  } catch {
    // Not a git repo
  }
  return cwd.split('/').pop() || cwd;
}

async function main(): Promise<void> {
  const apiKey = process.env.ANTHROPIC_AUTH_TOKEN ?? process.env.ANTHROPIC_API_KEY ?? '';

  if (!apiKey) {
    process.stdout.write(
      'Set ANTHROPIC_AUTH_TOKEN or ANTHROPIC_API_KEY to use the OpenRouter statusline',
    );
    return;
  }

  let inputData = '';
  for await (const chunk of process.stdin) {
    inputData += chunk;
  }

  const input: StatuslineInput = JSON.parse(inputData);
  const session_id = input?.session_id;
  const transcript_path = input?.transcript_path;

  if (typeof session_id !== 'string' || typeof transcript_path !== 'string') {
    process.stdout.write('Invalid statusline input');
    return;
  }

  // Extract info for the new display sections
  const version = input?.version ?? '';
  const currentDir = input?.workspace?.current_dir || input?.cwd || '';
  const branchName = currentDir ? getBranchOrFolder(currentDir) : '';
  const ctx = input?.context_window;
  const modelId = input?.model?.id;

  // Build context info string with progress bar
  let contextInfo = '';
  if (ctx && typeof ctx.used_percentage === 'number' && ctx.used_percentage !== null) {
    const bar = progressBar(ctx.used_percentage);
    const used = ctx.total_input_tokens ?? ctx.current_usage?.input_tokens ?? 0;
    const total = ctx.context_window_size ?? 0;
    contextInfo = ` ${bar} ${ctx.used_percentage.toFixed(0)}% (${formatNumber(used)} / ${formatNumber(total)})`;
  }

  const statePath = `/tmp/claude-openrouter-cost-${session_id}.json`;
  const state = loadState(statePath);

  const allIds = extractGenerationIds(transcript_path);
  const seenSet = new Set(state.seen_ids);
  const newIds = allIds.filter((id) => !seenSet.has(id));

  let fetchSucceeded = 0;
  let fetchFailed = 0;

  for (const id of newIds) {
    const gen = await fetchGeneration(id, apiKey);

    if (!gen) {
      fetchFailed++;
      continue;
    }

    fetchSucceeded++;
    state.total_cost += gen.total_cost ?? 0;
    state.total_cache_discount += gen.cache_discount ?? 0;

    if (gen.provider_name) {
      state.last_provider = gen.provider_name;
    }
    if (gen.model) {
      state.last_model = gen.model;
    }

    state.seen_ids.push(id);
  }

  saveState(statePath, state);

  const shortModel = shortModelName(state.last_model);

  // Build the cost portion
  let costStr: string;
  if (state.last_provider) {
    costStr = `${state.last_provider}: ${shortModel} | $${state.total_cost.toFixed(4)} (cache: $${state.total_cache_discount.toFixed(2)})`;
  } else {
    costStr = `${modelId} | $${state.total_cost.toFixed(4)} (cache: $${state.total_cache_discount.toFixed(2)})`;
  }

  // Build the additional info segments
  const segments: string[] = [];
  if (branchName) {
    segments.push(branchName);
  }
  if (version) {
    segments.push(`v${version}`);
  }

  let suffix = '';
  if (segments.length > 0 || contextInfo) {
    suffix = ` |${contextInfo}`;
    if (segments.length > 0) {
      suffix += ` | ${segments.join(' | ')}`;
    }
  }

  // Build status indicator line
  let statusIndicator = '';
  if (newIds.length > 0) {
    const green = '\x1b[32m';
    const red = '\x1b[31m';
    const reset = '\x1b[0m';

    if (fetchFailed === 0) {
      statusIndicator = `\nusage: ${green}ok${reset}`;
    } else {
      statusIndicator = `\nusage: ${red}behind${reset}`;
    }
  }

  process.stdout.write(`${costStr}${suffix}${statusIndicator}`);
}

main().catch((err) => {
  process.stdout.write(`error: ${err.message}`);
});
