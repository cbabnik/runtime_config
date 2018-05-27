# .bashrc

# Source system defintions
if [ -f /etc/bashrc ]; then
   source /etc/bashrc
fi

# expand history sizes
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=5000
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

# use a trash folder
export TRASH="$HOME/.Trash"
function rmtrash() { mv $@ $TRASH/; }

# combine cd and ls
function cl() { cd $1; ls; }

# macro to remove vim swap files
function remove_vim_swaps() { find ./ -type f -name "\.*sw[klmnop]" -delete; }

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
alias mkdir='mkdir -pv'
alias svim='sudo vim'
alias ..='cd ..'
alias ...='cd ...'
alias ....='cd ....'
alias .....='cd .....'
