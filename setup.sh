#!/bin/zsh
set -euo pipefail

echo "[*] INSTALLING TOOLS"
## Homebrew
if [ ! $(which brew) ]; then
  /bin/bash -c "$(curl -fLSs https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
## CLI
brew install git
brew install jq
## Node
brew install node
brew install yarn
## Vim
brew install ripgrep
brew install tmux
brew install vim
echo

echo "[*] LINKING FILES"
## Git
ln -fs "$PWD/configs/.gitconfig" "$HOME"
ln -fs "$PWD/configs/.gitignore" "$HOME"
## Terminal
ln -fs "$PWD/configs/.zshrc" "$HOME"
## Vim
VIM_DIRECTORY="$HOME/.vim/"
if [ ! -d "$VIM_DIRECTORY" ]; then
  mkdir "$VIM_DIRECTORY"
fi
ln -fs "$PWD/configs/.tmux.conf" "$HOME"
ln -fs "$PWD/configs/.vimrc" "$HOME"
ln -fs "$PWD/configs/coc-settings.json" "$VIM_DIRECTORY"
ln -fs "$PWD/UltiSnips/" "$VIM_DIRECTORY"
echo
