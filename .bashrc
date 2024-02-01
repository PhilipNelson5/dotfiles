#! /usr/bin/env bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=     #1000
export HISTFILESIZE= #2000
export HISTFILE=~/.bash_eternal_history
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias python=python3.11

export EDITOR=nvim
export PATH=$PATH:/opt/nvim/bin
alias vim='$EDITOR'
alias :e='$EDITOR'
alias lg=lazygit
alias ld=lazydocker
alias bashrc='$EDITOR ~/.bashrc && source ~/.bashrc'
alias vimrc='$EDITOR ~/.config/nvim/init.lua'
# alias ch='cd $(find ~/DEV ! -readable -prune -o \( -name node_modules \) -prune -o -type d -a -name .git -print -prune | sed -e s_/\.git__\ | fzf)'
alias ch='cd $(find ~/DEV -type d -execdir test -d {}/.git \; -prune -print | sed -e s_/\.git__\ | fzf)'
alias gits='~/git.sh'

# GIT
. "$HOME/.config/git-completion.bash"
. "$HOME/.config/git-prompt.sh"
alias g="git"
alias push="git push"
alias pull="git pull"
_completion_loader git
complete -o bashdefault -o default -o nospace -F __git_wrap__git_main g

# Update script
complete -W "dive gql lazygit neovim shellcheck" update

export PATH=$PATH:/opt/bin:~/bin
export PS1='\[\e]0;\w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \[\033[01;93m\]$(git rev-parse --short HEAD 2>/dev/null)\e[38;5;214m\]$(__git_ps1)$([[ -z $(git status --porcelain 2>/dev/null) ]] || echo "*")\[\033[00m\]\$ '

[ -f ~/.fzf.bash ] && source "$HOME/.fzf.bash"

export GPG_TTY=$(tty)

. "$HOME/.cargo/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
