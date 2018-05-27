# .bashrc

# Source system defintions
if [ -f /etc/bashrc ]; then
   source /etc/bashrc
fi

# use a trash folder
export TRASH="$HOME/.Trash"
function rmtrash() { mv $@ $TRASH/; }

# change timestamp format
export HISTTIMEFORMAT='%F %T '
# run any other prompt command, then print command to an eternal history
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"'echo $$ $USER \
                  "$(history 1)" >> ~/.bash_eternal_history'
if [ ! -e ~/.bash_eternal_history ]
then
   touch ~/.bash_eternal_history
   chmod 600 ~/.bash_eternal_history
fi

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
