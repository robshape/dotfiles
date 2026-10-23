#!/bin/zsh
set -euo pipefail

echo "[*] LINKING FILES"
if ! [[ -L "$HOME/.zshrc" ]]; then
  ## Claude Code
  CLAUDE_CODE_DIRECTORY="$HOME/.claude/"
  if ! [[ -d "$CLAUDE_CODE_DIRECTORY" ]]; then
    mkdir "$CLAUDE_CODE_DIRECTORY"
  fi
  ln -fs "$PWD/configs/.claudeignore" "$CLAUDE_CODE_DIRECTORY"
  ln -fs "$PWD/configs/settings.claude.json" "$CLAUDE_CODE_DIRECTORY/settings.json"
  ln -fs "$PWD/prompts/" "$CLAUDE_CODE_DIRECTORY/commands"
  ln -fs "$PWD/prompts/agents.instructions.md" "$CLAUDE_CODE_DIRECTORY/CLAUDE.md"

  ## Git
  ln -fs "$PWD/configs/.gitconfig" "$HOME"
  ln -fs "$PWD/configs/.gitignore" "$HOME"

  ## Pi
  PI_DIRECTORY="$HOME/.pi/agent/"
  if ! [[ -d "$PI_DIRECTORY" ]]; then
    mkdir -p "$PI_DIRECTORY"
    mkdir "$PI_DIRECTORY/prompts/"
    mkdir "$PI_DIRECTORY/themes/"
  fi
  ln -fs "$PWD/configs/models.pi.json" "$PI_DIRECTORY/models.json"
  ln -fs "$PWD/configs/settings.pi.json" "$PI_DIRECTORY/settings.json"
  ln -fs "$PWD/configs/theme.pi.json" "$PI_DIRECTORY/themes/pi.json"
  ln -fs "$PWD/extensions/pi/" "$PI_DIRECTORY/extensions"
  ln -fs "$PWD/prompts/agents.instructions.md" "$PI_DIRECTORY/AGENTS.override.md"
  find "$PWD/prompts/" -maxdepth 1 -type f -exec ln -fs {} "$PI_DIRECTORY/prompts/" \;

  ## Vim
  VIM_DIRECTORY="$HOME/.vim/"
  if ! [[ -d "$VIM_DIRECTORY" ]]; then
    mkdir "$VIM_DIRECTORY"
  fi
  ln -fs "$PWD/configs/.tmux.conf" "$HOME"
  ln -fs "$PWD/configs/.vimrc" "$HOME"
  ln -fs "$PWD/configs/coc-settings.json" "$VIM_DIRECTORY"
  ln -fs "$PWD/extensions/ultisnips/" "$VIM_DIRECTORY/UltiSnips"

  ## Visual Studio Code
  VISUAL_STUDIO_CODE_DIRECTORY="$HOME/Library/Application Support/Code/User/"
  if [[ -d "$VISUAL_STUDIO_CODE_DIRECTORY" ]]; then
    rm -fr "$VISUAL_STUDIO_CODE_DIRECTORY/prompts/"
    ln -fs "$PWD/configs/settings.code.json" "$VISUAL_STUDIO_CODE_DIRECTORY/settings.json"
    ln -fs "$PWD/prompts/" "$VISUAL_STUDIO_CODE_DIRECTORY"
  fi

  ## Terminal
  ln -fs "$PWD/configs/.zshrc" "$HOME"
  source "$HOME/.zshrc"
fi
echo

echo "[*] INSTALLING TOOLS"
## Xcode Command Line Developer Tools
if ! [[ $(xcode-select --install 2>&1 | grep installed) ]]; then
  xcode-select --install
  echo "Rerun this script after Xcode Command Line Developer Tools has finished installing"
  exit
fi

## Homebrew
if ! (($+commands[brew])) then
  /bin/bash -c "$(curl -fLSs https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
brew install --cask claude-code
brew install fzf
brew install git
brew install go
brew install llama.cpp
brew install node
brew install pi-coding-agent
brew install pnpm
brew install python@3.15
brew install ripgrep
brew install tmux
brew install uv
brew install vim
brew install yarn

## Vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo
