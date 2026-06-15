## ########
## Settings
## ########
autoload -Uz compinit && compinit
preexec() { clear }

## #####################
## Environment variables
## #####################
export BROWSER="none"
export CYPRESS_CACHE_FOLDER="$HOME/.cache/cypress/"
export CYPRESS_CRASH_REPORTS=0
export GOPATH="$HOME/.go"
export GOROOT="$(brew --prefix go)/libexec"
export PATH="/opt/homebrew/bin:$PATH:$GOPATH/bin/:$GOROOT/bin/:$HOME/.local/bin/"
export PROMPT="%2~ ⚡️ "

if [[ -f "$HOME/.zshrc.secrets" ]]; then
  source "$HOME/.zshrc.secrets"
fi

## #######
## Aliases
## #######
alias a="claude"
alias c="clear"
alias e="exit"
alias k="kill -9"
alias l="ls -a"
alias m="mkdir"
alias p="lsof -i"
alias t="touch"
alias y="cp"
alias yr="cp -R"
alias awake="caffeinate -dimsu"
alias checksum="shasum -a 256"
alias download="curl -LOC -"
alias permission="stat -f %A"
alias qwen="llama-server -m ~/Developer/oss/Qwen3.6-35B-A3B-MTP-UD-Q4_K_XL.gguf --mmproj ~/Developer/oss/Qwen3.6-35B-A3B-MTP-UD-mmproj-F16.gguf -c 131072 -fa on -ngl all -np 1 --min-p 0.00 --presence-penalty 0.0 --repeat-penalty 1.0 --spec-draft-n-max 2 --spec-type draft-mtp --temp 0.6 --top-k 20 --top-p 0.95"
alias size="du -hs"

alias ga="git add"
alias gaa="git add ."
alias gb="git branch"
alias gbd="git branch -D"
alias gbr="git branch -r"
alias gc="git checkout"
alias gcb="git checkout -b"
alias ge="git revert --no-edit"
alias gl="git log"
alias glf="git log --follow --"
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
alias gv="git mv"
alias gclean="git reset --hard && git stash clear && git clean -dfx && git gc"
alias gdiff="git add -N . && git difftool -t vimdiff"
alias gpick="git cherry-pick"
alias gundo="git reset --soft HEAD~1"

alias v="vim"
alias vr="vim -R"

## #########
## Functions
## #########
auth() {
  ssh-add ~/.ssh/shapeless-key
}

bellify() {
  "$@"
  printf "\a"
}

clean() {
  rm -fr ~/.local/
  rm -fr ~/.zsh_sessions/
  rm -fr ~/.lesshst
  rm -fr ~/.NERDTreeBookmarks
  rm -fr ~/.viminfo
  rm -fr ~/.vimspector.log
  rm -fr ~/.zcompdump
  rm -fr ~/.zsh_history
}

memory() {
  date=$(date "+%Y-%m-%d")
  time=$(date "+%H:%M:%S")
  memory_pressure=$(memory_pressure | grep "System-wide" | awk '{ print $5 }')
  swapusage=$(sysctl vm.swapusage | awk '{ print $7 }')
  echo "$date $time, $memory_pressure memory free, $swapusage swap used"
}

today() {
  NOTES="$HOME/Developer/Notes/"
  date=$(date "+%Y-%m-%d")
  cd "$NOTES" || exit
  if [[ ! -f "$date.md" ]]; then
    echo "# ${date}" > "$date.md"
  fi
  vim "$date.md"
}

update() {
  brew update
  brew upgrade
  brew cleanup -s
  rm -fr "$(brew --cache)"

  vim -c "PlugUpgrade | PlugUpdate | VimspectorUpdate | CocUpdate"
}

gclone() {
  git clone git@github.com:"$1".git
}

gcompare() {
  git diff main.."$(git branch --show-current)"
}

gcontinue() {
  branch=$(git rev-parse --abbrev-ref HEAD)
  if [[ "$branch" != "main" ]] && [[ -z "$(git status --porcelain)" ]]; then
    git checkout main
    git pull
    git fetch -Pp

    git checkout "$branch"
    git fetch
    git merge --no-edit origin/main

    git checkout main
    git checkout -b "$1"

    git merge --squash "$branch"
    git commit -m "$branch"
  fi
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

grebase() {
  git fetch

  if [[ -n "$1" ]]; then
    git merge --no-edit origin/"$1"
  else
    git merge --no-edit origin/main
  fi
}

gsquash() {
  branch=$(git rev-parse --abbrev-ref HEAD)
  if [[ "$branch" != "main" ]] && [[ -z "$(git status --porcelain)" ]]; then
    git checkout main
    git merge --squash "$branch"
    git commit -m "$1"
    git branch -D "$branch"
  fi
}

gupdate() {
  git pull
  git fetch -Pp

  if [[ "$1" = "n" ]]; then
    npm ci
  elif [[ "$1" = "p" ]]; then
    pnpm i --frozen-lockfile
  elif [[ "$1" = "u" ]]; then
    uv sync
  elif [[ "$1" = "y" ]]; then
    yarn install --frozen-lockfile
  fi
}

tlayout() {
  tmux split-window -h
  tmux split-window -h
  tmux select-layout even-horizontal
  tmux select-pane -t 1
  tmux split-window -v
}

tstart() {
  if [[ -z "$TMUX" ]]; then
    tmux new-session -As main
  fi
}

tstop() {
  if [[ -n "$TMUX" ]]; then
    tmux kill-session -a
    tmux kill-session
  fi
}
