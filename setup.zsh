#!/bin/zsh
set -euo pipefail

echo "[*] INSTALLING TOOLS"
## Xcode Command Line Developer Tools
if [[ ! $(xcode-select --install 2>&1 | grep installed) ]] then
  xcode-select --install
  echo "Rerun this script after Xcode Command Line Developer Tools has finished installing"
  exit
fi

## Homebrew
if ! (($+commands[brew])) then
  /bin/bash -c "$(curl -fLSs https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

### Development
brew install git
brew install jq
brew install node
brew install yarn

### Vim
brew install ripgrep
brew install tmux
brew install vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo

echo "[*] LINKING FILES"
## Git
ln -fs "$PWD/configs/.gitconfig" "$HOME"
ln -fs "$PWD/configs/.gitignore" "$HOME"

## Terminal
ln -fs "$PWD/configs/.zshrc" "$HOME"

## Vim
VIM_DIRECTORY="$HOME/.vim/"
ln -fs "$PWD/configs/.tmux.conf" "$HOME"
ln -fs "$PWD/configs/.vimrc" "$HOME"
ln -fs "$PWD/configs/coc-settings.json" "$VIM_DIRECTORY"
ln -fs "$PWD/UltiSnips/" "$VIM_DIRECTORY"
echo
