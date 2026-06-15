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
  ln -fs "$PWD/prompts/agents.instructions.md" "$CLAUDE_CODE_DIRECTORY/CLAUDE.md"
  ln -fs "$PWD/prompts/" "$CLAUDE_CODE_DIRECTORY/commands"

  ## Git
  ln -fs "$PWD/configs/.gitconfig" "$HOME"
  ln -fs "$PWD/configs/.gitignore" "$HOME"

  ## Vim
  VIM_DIRECTORY="$HOME/.vim/"
  if ! [[ -d "$VIM_DIRECTORY" ]]; then
    mkdir "$VIM_DIRECTORY"
  fi
  ln -fs "$PWD/configs/.tmux.conf" "$HOME"
  ln -fs "$PWD/configs/.vimrc" "$HOME"
  ln -fs "$PWD/configs/coc-settings.json" "$VIM_DIRECTORY"
  ln -fs "$PWD/UltiSnips/" "$VIM_DIRECTORY"

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
brew install pnpm
brew install ripgrep
brew install rtk
brew install tmux
brew install uv
brew install vim
brew install yarn

## Vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo
