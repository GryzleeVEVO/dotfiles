# bash rc
# Interactive shell settings

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Prompt
PS1='[\u@\h \W]\$ '

# Imports source files for bash
export BASH_CONFIG_PATH="$HOME/.config/bash"
for f in "$BASH_CONFIG_PATH/*"; do source $f; done


# Include files starting with . when globbing (excl. '.' and '..')
shopt -s dotglob

# Extended globbing
shopt -s extglob

# Case-insensitive globbing
shopt -s nocaseglob

# Autocorrect minor typos when using cd
shopt -s cdspell

# If command is name of directory, cd into it
shopt -s autocd
