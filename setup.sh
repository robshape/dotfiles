#!/bin/bash
set -euo pipefail

echo "[*] INSTALLING TOOLS"
## Homebrew
if [ ! $(which brew) ]; then
  /bin/bash -c "$(curl -fLSs https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi
## Databases
brew install mongodb
brew install postgresql
## Git
brew install act
brew install gh
brew install git
## Kubernetes
brew install helm
## Node
brew install node
## Python
brew install python
## React Native
brew install watchman
sudo gem install cocoapods
## Rust
if [ ! $(which rustup) ]; then
  curl --proto "=https" --tlsv1.2 -fSs https://sh.rustup.rs/ | sh
fi
rustup component add rls
rustup component add rust-analysis
rustup component add rust-src
## Vim
brew install ripgrep
brew install tmux
brew install vim
echo

if [ $(which code) ]; then
  echo "[*] INSTALLING VISUAL STUDIO CODE EXTENSIONS"
  code --install-extension adamgirton.gloom
  code --install-extension christian-kohler.npm-intellisense
  code --install-extension christian-kohler.path-intellisense
  code --install-extension davidanson.vscode-markdownlint
  code --install-extension dbaeumer.vscode-eslint
  code --install-extension eg2.vscode-npm-script
  code --install-extension esbenp.prettier-vscode
  code --install-extension juanblanco.solidity
  code --install-extension mikestead.dotenv
  code --install-extension ms-azuretools.vscode-docker
  code --install-extension ms-python.python
  code --install-extension msjsdiag.debugger-for-chrome
  code --install-extension msjsdiag.vscode-react-native
  code --install-extension rust-lang.rust
  code --install-extension streetsidesoftware.code-spell-checker
  code --install-extension stylelint.vscode-stylelint
  code --install-extension vscodevim.vim
  echo
fi

echo "[*] LINKING FILES"
## Git
ln -fs "$PWD/configs/.gitconfig" "$HOME"
ln -fs "$PWD/configs/.gitignore" "$HOME"
## Terminal
ln -fs "$PWD/configs/.bash_profile" "$HOME"
## Vim
VIM_DIRECTORY="$HOME/.vim/"
if [ ! -d "$VIM_DIRECTORY" ]; then
  mkdir "$VIM_DIRECTORY"
fi
ln -fs "$PWD/configs/.vimrc" "$HOME"
ln -fs "$PWD/configs/coc-settings.json" "$VIM_DIRECTORY"
ln -fs "$PWD/UltiSnips/" "$VIM_DIRECTORY"
## Visual Studio Code
VISUAL_STUDIO_CODE_USER_DIRECTORY="$HOME/Library/Application Support/Code/User/"
if [ -d "$VISUAL_STUDIO_CODE_USER_DIRECTORY" ]; then
  ln -fs "$PWD/configs/settings.json" "$VISUAL_STUDIO_CODE_USER_DIRECTORY"
  VISUAL_STUDIO_CODE_REACT_NATIVE_DIRECTORY="$HOME/.vscode-react-native/"
  if [ ! -d "$VISUAL_STUDIO_CODE_REACT_NATIVE_DIRECTORY" ]; then
    mkdir "$VISUAL_STUDIO_CODE_REACT_NATIVE_DIRECTORY"
  fi
  ln -fs "$PWD/configs/VSCodeTelemetrySettings.json" "$VISUAL_STUDIO_CODE_REACT_NATIVE_DIRECTORY"
fi
echo

echo "[*] NOTES"
echo "- Change Terminal font to SF Mono Regular 12 pt. and disable 'Antialias text'"
echo "- Map CAPS LOCK key to ESC key"
echo "- Update ./configs/.gitconfig email"
echo
