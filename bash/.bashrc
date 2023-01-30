# bash rc
# Interactive shell settings
# Mainly contains exported variables and includes other files

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Updates LINES and COLUMNS after every command
shopt -s checkwinsize

# Use neovim as the default editor, if available
[ -x "$(command -v nvim)" ] && export EDITOR='nvim' 

# Sources the rest of the config 
export BASH_CONFIG_PATH="$HOME/.config/bash"
for f in $BASH_CONFIG_PATH/*; do source $f; done
