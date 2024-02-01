#!/usr/bin/env bash

. "$HOME/.config/git-prompt.sh"
# shellcheck disable=SC2016
PROMPT='\e[38;5;214m\]$(__git_ps1)$([[ -z $(git status --porcelain 2>/dev/null) ]] || echo "*")\[\033[00m\] git > '
hist_ptr=-1
mapfile -t _history < <(sed -nre 's/^git (.*)$/\1/p' "$HISTFILE" | uniq)

function _reverse_search {
  _overwrite "$(
    fzf --bind=ctrl-z:ignore < <(
      IFS=$'\n'
      echo "${_history[*]}" | tac
    )
  )"
}

function _up {
  ((hist_ptr++))
  _overwrite "${_history[((${#_history[@]} - $hist_ptr - 1))]}"
}

function _down {
  ((hist_ptr--))
  if ((hist_ptr < -1)); then
    hist_ptr=-1
    _overwrite ''
  else
    _overwrite "${_history[((${#_history[@]} - $hist_ptr - 1))]}"
  fi
}

function _overwrite {
  line=$1
  printf "\33[2K\r${PROMPT@P}%s" "$line"
}

function _eval {
  [[ -z $line ]] && echo && return
  cmd="git $line"
  if [[ ${_history[-1]} != "$line" ]]; then
    _history+=("$line")
    # echo "$cmd" > "$HISTFILE"
  fi
  printf "\n"
  eval "$cmd"
  hist_ptr=-1
}

while true; do
  printf "%s" "${PROMPT@P}"
  line=''

  while IFS= read -rsN 1 ch; do
    # printf "%s\n" "${ch@Q}"
    case "$ch" in
    $'\04') # ^D
      EOF=1
      break
      ;;
    $'\022') # ^R
      _reverse_search
      ;;
    $'\177') # Backspace
      printf "\b \b"
      ((${#line} > 0)) && line=${line::-1}
      ;;
    $'\E')
      read -rsN2 code
      case $code in
      '[A') _up ;;
      '[B') _down ;;
      # '[C') echo RIGHT ;;
      # '[D') echo LEFT ;;
      esac
      ;;
    $'\n') break ;;
    *)
      printf "%s" "$ch"
      line="$line$ch"
      ;;
    esac
  done

  _eval

  if ((EOF)); then
    break
  fi
done
