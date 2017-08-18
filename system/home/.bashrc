# .bashrc

# Source system defintions
if [ -f /etc/bashrc ]; then
   source /etc/bashrc
fi

# use a trash folder
export TRASH="$HOME/.Trash"
function rmtrash() { mv $@ $TRASH/; }

# combine cd and ls
function cl() { cd $1; ls; }

# macro to remove vim swap files
function remove_vim_swaps() { find ./ -type f -name "\.*sw[klmnop]" -delete; }

alias rm='rm -Iv'
alias mv='mv -iv'
alias ll='ls -lG'
alias la='ls -A'
alias svim='sudo vim'
alias ..='cd ..'
alias ...='cd ...'
alias ....='cd ....'
alias .....='cd .....'
