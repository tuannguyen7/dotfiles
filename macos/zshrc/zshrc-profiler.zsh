#!/usr/bin/env zsh
#
# zshrc profiler — measures startup time of each section in your .zshrc
#
# Usage:
#   zsh ~/personal-workspace/dotfiles/macos/zshrc/zshrc-profiler.zsh
#

zmodload zsh/datetime

# ─── Section-level profiling ──────────────────────────────────────────────────

typeset -A _prof_times
typeset -a _prof_order
_prof_total_start=$EPOCHREALTIME

_prof_start() {
  _prof_order+=("$1")
  local key="${1}_start"
  _prof_times[$key]=$EPOCHREALTIME
}

_prof_end() {
  local end=$EPOCHREALTIME
  local skey="${1}_start"
  local ekey="${1}_elapsed"
  local start=${_prof_times[$skey]}
  _prof_times[$ekey]=$(( (end - start) * 1000 ))
}

_prof_report() {
  local total_elapsed=$(( (EPOCHREALTIME - _prof_total_start) * 1000 ))
  local bar_max=40

  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "  zshrc startup profiler"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  printf "  %-35s %8s  %s\n" "SECTION" "TIME(ms)" "BAR"
  echo "──────────────────────────────────────────────────────────────────────────"

  for section in "${_prof_order[@]}"; do
    local ekey="${section}_elapsed"
    local elapsed=${_prof_times[$ekey]}
    local pct=0
    if (( total_elapsed > 0 )); then
      pct=$(( elapsed * 100.0 / total_elapsed ))
    fi
    local bar_len=$(( ${elapsed%.*} * bar_max / ${total_elapsed%.*} ))
    (( bar_len < 0 )) && bar_len=0
    local bar=""
    for ((i=0; i<bar_len; i++)); do bar+="█"; done

    if (( elapsed > 200 )); then
      printf "  \033[31m%-35s %6.0f ms  %s (%.0f%%)\033[0m\n" "$section" "$elapsed" "$bar" "$pct"
    elif (( elapsed > 50 )); then
      printf "  \033[33m%-35s %6.0f ms  %s (%.0f%%)\033[0m\n" "$section" "$elapsed" "$bar" "$pct"
    else
      printf "  \033[32m%-35s %6.0f ms  %s (%.0f%%)\033[0m\n" "$section" "$elapsed" "$bar" "$pct"
    fi
  done

  echo "──────────────────────────────────────────────────────────────────────────"
  printf "  %-35s %6.0f ms\n" "TOTAL" "$total_elapsed"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""
}

# ─── Profile each section (synced with dot-zshrc) ─────────────────────────────

_prof_start "oh-my-zsh init"
ZSH_DISABLE_COMPFIX=true
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git tmux fzf virtualenv)
source $ZSH/oh-my-zsh.sh
_prof_end "oh-my-zsh init"

_prof_start "env exports"
export KUBE_EDITOR="/usr/local/bin/nvim"
export TERM=xterm-256color
_prof_end "env exports"

_prof_start "aliases & functions"
git_push_curr_branch() {
  git push -u origin `git branch --show-current`
}
cd_to_workspace() {
  BASE_DIR=~
  SELECTED_DIR=`({cd $BASE_DIR && ls -d workspace/* && ls -d personal-workspace/* } | fzf)&`
  if [ -n "$SELECTED_DIR" ]; then
    cd $BASE_DIR/$SELECTED_DIR
  fi
}
alias vim="nvim"
alias v="nvim"
alias gd="git diff --color | diff-so-fancy"
alias k="kubectl"
alias gps=git_push_curr_branch
alias gpl="git pull"
alias cdwsp=cd_to_workspace
_prof_end "aliases & functions"

_prof_start "fzf"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
_prof_end "fzf"

_prof_start "PATH setup"
export PATH="/Users/tunguyen/.local/bin:/usr/local/sbin:$PATH"
_prof_end "PATH setup"

_prof_start "java_home"
export JAVA_HOME=`/usr/libexec/java_home -v 11`
_prof_end "java_home"

_prof_start "go"
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
_prof_end "go"

_prof_start "zshrc-work"
[ -f "$HOME/.zshrc-work" ] && source "$HOME/.zshrc-work"
_prof_end "zshrc-work"

_prof_start "zsh-autosuggestions"
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
_prof_end "zsh-autosuggestions"

_prof_start "nvm (lazy)"
export NVM_DIR="$HOME/.nvm"
_lazy_init_nvm() {
  unfunction nvm node npm npx 2>/dev/null
  source /opt/homebrew/opt/nvm/nvm.sh
}
for cmd in nvm node npm npx; do
  eval "${cmd}() { _lazy_init_nvm; ${cmd} \"\$@\" }"
done
_prof_end "nvm (lazy)"

_prof_start "pyenv (lazy)"
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
_lazy_init_pyenv() {
  unfunction pyenv python python3 pip pip3 2>/dev/null
  eval "$(pyenv init -)"
}
for cmd in pyenv python python3 pip pip3; do
  eval "${cmd}() { _lazy_init_pyenv; ${cmd} \"\$@\" }"
done
_prof_end "pyenv (lazy)"

_prof_start "sdkman (lazy)"
export SDKMAN_DIR="/opt/homebrew/opt/sdkman-cli/libexec"
_lazy_init_sdkman() {
  unfunction sdk java javac gradle maven mvn 2>/dev/null
  [[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"
}
for cmd in sdk java javac gradle maven mvn; do
  eval "${cmd}() { _lazy_init_sdkman; ${cmd} \"\$@\" }"
done
_prof_end "sdkman (lazy)"

_prof_start "misc"
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status virtualenv)
_prof_end "misc"

# ─── Print report ─────────────────────────────────────────────────────────────
_prof_report

# ─── Benchmark: full zshrc load (5 runs) ─────────────────────────────────────
echo "  Benchmarking full zshrc load (5 runs)..."
_bench_total=0
for i in 1 2 3 4 5; do
  _bench_start=$EPOCHREALTIME
  zsh -i -c exit 2>/dev/null
  _bench_elapsed=$(( (EPOCHREALTIME - _bench_start) * 1000 ))
  _bench_total=$(( _bench_total + _bench_elapsed ))
  printf "    Run %d: %.0f ms\n" "$i" "$_bench_elapsed"
done
_bench_avg=$(( _bench_total / 5 ))
echo ""
printf "  Average: %.0f ms\n" "$_bench_avg"
echo ""
