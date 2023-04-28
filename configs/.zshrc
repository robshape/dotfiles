## #####################
## Environment variables
## #####################
export BROWSER="none"
export CYPRESS_CACHE_FOLDER="~/.cache/cypress"
export CYPRESS_CRASH_REPORTS=0
export PATH="/opt/homebrew/bin:$PATH"

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

alias ga="git add ."
alias gb="git branch"
alias gbd="git branch -D"
alias gbr="git branch -r"
alias gc="git checkout"
alias gcb="git checkout -b"
alias gl="git log"
alias gm="git commit"
alias gp="git push"
alias gr="git reset"
alias grh="git reset --hard"
alias gs="git status"
alias gt="git stash -ku"
alias gtp="git stash pop"
alias gclean="git reset --hard && git clean -dfx && git gc"
alias gdiff="git add -N . && git difftool -t vimdiff"
alias grebase="git fetch && git merge origin/main"
alias gundo="git reset --soft HEAD~1"

## #########
## Functions
## #########
gclone() {
  git clone git@github.com:$1.git
}

gcompare() {
  git diff main..$(git branch --show-current)
}

gpick() {
  git checkout $1 -- $2
}

gpickall() {
  git merge --no-commit --no-ff --squash $1
  git reset
}

gpr() {
  git fetch origin pull/$1/head:pr/$1
  git checkout pr/$1
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
  git push -u origin $(git symbolic-ref -q --short HEAD)
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
  vim -c 'PlugUpgrade | PlugUpdate | CocUpdate'
}
