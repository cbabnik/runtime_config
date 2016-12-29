# .bashrc

# Source system defintions
if [ -f /etc/bashrc ]; then
   . /etc/bashrc
fi

# enable bash vi-mode. use "bind -P" to see bindings
set -o vi

# use a trash folder
export TRASH="$HOME/.Trash"
function rmtrash() { mv $@ $TRASH/; }

# combine cd and ls
function cl() { cd $1; ls; }

alias rm='rm -Iv'
alias mv='mv -iv'
alias ll='ls -lG'
alias la='ls -A'
alias ..='cd ..'
alias ...='cd ...'
alias ....='cd ....'
alias .....='cd .....'
