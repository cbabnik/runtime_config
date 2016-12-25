# .bashrc

# Source system defintions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# enable bash vi-mode. use "bind -P" to see bindings
set -o vi

alias rm='rm -Iv'
alias mv='mv -iv'
alias ll='ls -lG'
alias la='ls -A'
alias ..='cd ..'
alias ...='cd ...'
alias ....='cd ....'
alias .....='cd .....'
