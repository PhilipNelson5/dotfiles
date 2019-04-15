# source ~/.zshrc
ZSH_DISABLE_COMPFIX=true

# Path to your oh-my-zsh installation.
export ZSH=/home/philip/.oh-my-zsh

# Extra paths
export PATH=$PATH:/home/philip/node_modules/.bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.gem/ruby/2.6.0/bin
export PATH=$PATH:$HOME/.local/bin
# Path to Android SKD
export ANDROID_HOME=/opt/android

ZSH_THEME="agnoster"

plugins=(autojump, extract)

source $ZSH/oh-my-zsh.sh

DISABLE_UPDATE_PROMPT=true

export BROWSER="google-chrome-stable"
export EDITOR=nvim
export PAGER=less

bindkey -v
bindkey '^R' history-incremental-search-backward

########################################################################
#                               Aliases                                #
########################################################################

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

[ -z "$PS1" ] && return # only for interactive mode

# vim style!
alias :e='vim'                       # edit a file
alias :q='exit'                      # close the terminal

alias bye='sudo shutdown now'        # shutdown system
alias c='clear'                      # clear terminal
alias zx='exit'                      # exits terminal
alias q='exit'                      # exits terminal

# dotfile shortcuts
alias Xrec='$EDITR ~/.Xresources'       # change Xresources
alias i3rc='$EDITR ~/.i3/config'        # change i3 config
alias vimrc='$EDITR ~/.vimrc'           # change vimrc
alias zshrc='$EDITR ~/.zshrc'           # change zshrc

# fix mistakes
alias cs='cd'                        # fix my mistakes
alias maek='make'                    # fix my mistakes
alias sl='ls'                        # fix my mistakes

alias please='sudo $(fc -ln -1)'     # run last command with elevated privileges if you ask nicely
alias plz='sudo $(fc -ln -1)'        # run last command with elevated privileges if you ask nicely
alias pls='sudo $(fc -ln -1)'        # run last command with elevated privileges if you ask nicely

# colors
alias color='colorize'
alias dir='dir --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias vdir='vdir --color=auto'

# shortcuts to some scripts
alias update='~/scripts/update.sh'   # update packages
alias push='~/scripts/push.sh'       # push to the current git branch

# some program shortcuts
alias image='viewnior'               # for opening images
alias intellij='/opt/idea-IU-163.11103.6/bin/idea.sh&' # launch intellij from terminal
alias python='python3'               # default to python3
alias r='ranger'                     # run ranger
alias render='markdown-pdf -s ~/github.css' # render markdown to pdfs with github style sheet
alias untar='tar -xzvf'              # untar a tarball
alias rss='newsboat'
alias se='stack exec'
alias sb='stack build'
alias sink='sudo /usr/sbin/ntpdate -u 0.pool.ntp.org'

function chpwd() {                   # always ls after changing directories
  emulate -L zsh
  ls
}

function colors() {
  local fgc bgc vals seq0

  printf "Color escapes are %s\n" '\e[${value};...;${value}m'
  printf "Values 30..37 are \e[33mforeground colors\e[m\n"
  printf "Values 40..47 are \e[43mbackground colors\e[m\n"
  printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

  # foreground colors
  for fgc in {30..37}; do
    # background colors
    for bgc in {40..47}; do
      fgc=${fgc#37} # white
      bgc=${bgc#40} # black

      vals="${fgc:+$fgc;}${bgc}"
      vals=${vals%%;}

      seq0="${vals:+\e[${vals}m}"
      printf "  %-9s" "${seq0:-(default)}"
      printf " ${seq0}TEXT\e[m"
      printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
    done
    echo; echo
  done
}

function groot() { # go to the root directory of a git repo
  emulate -L zsh
  if  [[ -e .git ]]; then
    return
  elif [[ $(pwd) == $HOME ]]; then
    return
  elif [[ $(pwd) == "/" ]]; then
    return
  else
    cd ..
    groot
  fi
}

function swap() {
  local TMPFILE=tmp.$$
  mv "$1" $TMPFILE
  mv "$2" "$1"
  mv $TMPFILE "$2"
}

[[ -s /home/philip/.autojump/etc/profile.d/autojump.sh ]] && source /home/philip/.autojump/etc/profile.d/autojump.sh

autoload -U compinit && compinit -u

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
