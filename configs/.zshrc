## ########
## Settings
## ########
autoload -Uz compinit && compinit
preexec() { clear }

## #####################
## Environment variables
## #####################
export BROWSER="none"
export CYPRESS_CACHE_FOLDER="$HOME/.cache/cypress"
export CYPRESS_CRASH_REPORTS=0
export PATH="/opt/homebrew/bin:$PATH"
export PROMPT="%2~ ⚡️ "

export GOPATH="$HOME/.go"
export GOROOT="$(brew --prefix go)/libexec"
export PATH="$PATH:$GOPATH/bin:$GOROOT/bin"

## #######
## Aliases
## #######
alias c="clear"
alias e="exit"
alias l="ls -a"
alias v="vim"
alias vr="vim -R"
alias awake="caffeinate -dimsu"
alias checksum="shasum -a 256"
alias download="curl -LOC -"
alias permission="stat -f %A"
alias size="du -hs"

alias ga="git add"
alias gaa="git add ."
alias gb="git branch"
alias gbd="git branch -D"
alias gbr="git branch -r"
alias gc="git checkout"
alias gcb="git checkout -b"
alias gl="git log"
alias gls="git show"
alias gm="git commit --no-edit"
alias gmm="git commit -m"
alias gp="git push"
alias gr="git reset"
alias grh="git reset --hard"
alias gs="git status"
alias gt="git stash -ku"
alias gtc="git stash clear"
alias gtl="git stash list"
alias gtp="git stash pop"
alias gv="git revert --no-edit"
alias gclean="git reset --hard && git clean -dfx && git gc"
alias gdiff="git add -N . && git difftool -t vimdiff"
alias gpick="git cherry-pick"
alias grebase="git fetch && git merge --no-edit origin/main"
alias gundo="git reset --soft HEAD~1"

## #########
## Functions
## #########
gclone() {
  git clone git@github.com:"$1".git
}

gcompare() {
  git diff main.."$(git branch --show-current)"
}

gcontinue() {
  git checkout main
  git pull
  git fetch -p

  git checkout "$1"
  git fetch
  git merge --no-edit origin/main

  git checkout main
  git checkout -b "$2"

  git merge --squash "$1"
  git commit -m "$1"
}

glog() {
  git log -P --author='^((?!dependabot).*)$'
}

gpickbranch() {
  git merge --squash "$1"
  git reset
}

gpickfile() {
  git checkout "$1" -- "$2"
}

gpr() {
  git fetch origin pull/"$1"/head:pr/"$1"
  git checkout pr/"$1"
}

gupdate() {
  git pull
  git fetch -p

  if [ "$1" = "n" ]; then
    npm ci
  elif [ "$1" = "y" ]; then
    yarn install --frozen-lockfile
  fi
}

gupload() {
  git push -u origin "$(git symbolic-ref -q --short HEAD)"
}

tauth() {
  ssh-add ~/.ssh/shapeless-key
}

tclean() {
  rm -fr ~/.zsh_sessions/
  rm -fr ~/.NERDTreeBookmarks
  rm -fr ~/.viminfo
  rm -fr ~/.zsh_history
}

tstart() {
  if [ -z "$TMUX" ]; then
    tmux new-session -As main
  fi
}

tstop() {
  if [ -n "$TMUX" ]; then
    tmux kill-session -a
    tmux kill-session
  fi
}

tupdate() {
  brew update
  brew upgrade
  brew cleanup -s
  rm -fr "$(brew --cache)"

  vim -c "PlugUpgrade | PlugUpdate | VimspectorUpdate | CocUpdate"
}
