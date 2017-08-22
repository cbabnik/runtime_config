# .bash_profile

# bash_profile is used in place of bashrc for login shells
# (If you login to your computer or ssh for example)

# For now I want it to just source my .bashrc

if [ -f $HOME/.bashrc ]; then
   source $HOME/.bashrc
fi
