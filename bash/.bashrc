# bash rc
# Interactive shell settings

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Imports source files for bash
export BASH_CONFIG_PATH="$HOME/.config/bash"

for f in $BASH_CONFIG_PATH/*; do source $f; done

# Updates LINES and COLUMNS after every command
shopt -s checkwinsize