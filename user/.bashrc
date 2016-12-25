# .bashrc

# Source system defintions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# enable bash vi-mode, use "bind -P" to see bindings
set -o vi

# generate completions for sudo and man-pages
complete -cf sudo man
shopt -s cdspell  # enable cd typo correction
shopt -s dirspell # enable tab completion correction

alias rm='rm -Iv'
alias mv='mv -iv'
alias ls='ls --color -h'
alias ll='ls -lG'
alias la='ls -A'
alias grep='grep --color'
alias ..='cd ..'
alias ...='cd ...'
alias ....='cd ....'
alias .....='cd .....'
