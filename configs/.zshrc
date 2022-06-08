## #####################
## Environment variables
## #####################
export BROWSER="none"
export CYPRESS_CACHE_FOLDER="~/.cache/cypress"
export CYPRESS_CRASH_REPORTS=0
export PATH="/opt/homebrew/bin:$PATH"
export TERM="screen-256color"

## #######
## Aliases
## #######
alias c="clear"
alias gb="git branch"
alias gc="git checkout"
alias gpop="git stash pop"
alias gs="git status"
alias gstash="git stash -ku"
alias gundo="git reset --soft HEAD~1"

## #########
## Functions
## #########
depupdate() {
  brew update
  brew upgrade
  brew cleanup -s
  rm -fr "$(brew --cache)"
}

gclean() {
  git reset --hard
  git clean -dfx
  git gc
}

gfpush() {
  git push -u origin $(git symbolic-ref -q --short HEAD)
}

gpull() {
  git pull
  git fetch -p
}

tclean() {
  rm -fr ~/.zsh_sessions/
  rm -fr ~/.NERDTreeBookmarks
  rm -fr ~/.viminfo
  rm -fr ~/.zsh_history
}

vdiff() {
  git add -N .
  git difftool -t vimdiff
}

vkeys() {
  ssh-add ~/.ssh/shapeless-key
}

vstart() {
  if [ -z "$TMUX" ]; then
    tmux new-session -As main
  fi
}

vstop() {
  if [ -n "$TMUX" ]; then
    tmux kill-session -a
    tmux kill-session
  fi
}
