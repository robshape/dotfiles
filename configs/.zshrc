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

alias awake="caffeinate -dimsu"
alias download="curl -LO -C -"
alias permission="stat -f %A"
alias size="du -hs"

alias dprune="docker system prune -af -volumes"

alias ga="git add ."
alias gb="git branch"
alias gbd="git branch -D"
alias gbr="git branch -r"
alias gc="git checkout"
alias gcb="git checkout -b"
alias gcommit="git commit"
alias gl="git log"
alias gp="git push"
alias gpop="git stash pop"
alias gr="git reset"
alias grebase="git fetch && git merge origin/main"
alias grh="git reset --hard"
alias gs="git status"
alias gstash="git stash -ku"
alias gundo="git reset --soft HEAD~1"

## #########
## Functions
## #########
gcfpr() {
  git fetch origin pull/$1/head:pr/$1
  git checkout pr/$1
}

gclean() {
  git reset --hard
  git clean -dfx
  git gc
}

gclone() {
  git clone git@github.com:$1.git
}

gcompare() {
  git diff main..$(git branch --show-current)
}

gdiff() {
  git add -N .
  git difftool -t vimdiff
}

gpick() {
  git checkout $1 -- $2
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
