## #####################
## Environment variables
## #####################
export CYPRESS_CACHE_FOLDER="~/.cache/cypress"
export CYPRESS_CRASH_REPORTS=0
export GOPATH="$HOME/.go"
export GOROOT="$(brew --prefix go)/libexec"
export PATH="$GOPATH/bin:$GOROOT/bin:$HOME/.cargo/bin:$PATH"
export TERM="screen-256color"

## #######
## Aliases
## #######
alias c="clear"
alias dps="docker ps"
alias dpurge="docker system prune -af --volumes"
alias fspace="find ~/ -path */Library/* -prune -false -o -iname \" *.*\" -o -iname \"*.* \" -o -iname \" *\" -o -iname \"* \""
alias gb="git branch"
alias gc="git checkout"
alias gs="git status"
alias gundo="git reset --soft HEAD~1"
alias ghpr="gh pr create -df"
alias kpods="kubectl get pods"
alias ndated="npm outdated"
alias nkill="pkill node"
alias tpython="source ~/.venv/bin/activate"

## #########
## Functions
## #########
drun() {
  docker run -p $2:$2 --rm $1
}

dshell() {
  docker exec -it $1 sh
}

deplist() {
  brew leaves
  #brew list
  #brew cask list
  npm list --depth=0 --global
}

depupdate() {
  brew update
  brew upgrade
  #npm update -g
  rustup update
  brew cleanup -s
  rm -fr "$(brew --cache)"
}

fdiff() {
  opendiff $1 $2
}

gclean() {
  git reset --hard
  git checkout master
  git clean -dfx
  git gc
}

ginspect() {
  find ~/Developer/ -name .git -type d | while read d
  do
    echo "[*] INSPECTING \"$d\""
    git --git-dir="$d" --work-tree="$d/.." status -b -s
    echo
  done
}

gpick() {
  git checkout $1 -- $2
}

gpull() {
  git pull
  git fetch -p
}

ghuser() {
  git config user.email robshape@users.noreply.github.com
  git config user.name robshape
}

ninstall() {
  rm -fr node_modules/
  rm -fr package-lock.json
  npm install
}

tclean() {
  #sudo find / -d -name ".DS_Store" -exec rm {} \;
  sudo periodic daily monthly weekly
  rm -fr ~/.cache/
  rm -fr ~/.cargo/registry/
  rm -fr ~/.config/configstore/
  rm -fr ~/.docker/application-template/cache/
  rm -fr ~/.docker/application-template/logs/
  rm -fr ~/.kube/cache/
  rm -fr ~/.node-gyp/
  rm -fr ~/.npm/
  rm -fr ~/.NERDTreeBookmarks
  rm -fr ~/.viminfo
  rm -fr ~/.bash_sessions/
  rm -fr ~/.bash_history
}

vclean() {
  if [ -z "$TMUX" ]; then
    echo "[*] NOT USING TMUX!"
    exit 1
  fi
  echo "[*] rm -fr ~/.bash_sessions/ ~/.bash_history AFTER TMUX EXITS"
  tclean
  tmux kill-session -a
  tmux kill-session
}

vdiff() {
  git add -N .
  git difftool -t vimdiff
}

vtmux() {
  if [ -z "$TMUX" ]; then
    tmux new-session -As main
  fi
}
