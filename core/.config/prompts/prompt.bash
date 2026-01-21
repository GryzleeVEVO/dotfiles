#!/usr/bin/env bash

# Show last 3 directories in cwd
PROMPT_DIRTRIM=3

# Print git repository status. If there are uncommited files, mark it
__prompt_git_status__() {
  local git_dirty git_branch

  if [[ $(git status --porcelain 2>/dev/null) ]]; then
    git_dirty=" *"
  else
    git_dirty=""
  fi

  git_branch="$(git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/( \1${git_dirty}) /")"

  echo -e "${git_branch}"
}

# Returns colored exit status between brackets
__prompt_exit_status__() {
  local exit="$?" color_exit

  if [[ $exit = 0 ]]; then
    color_exit="$(tput setaf 118)"
  else
    color_exit="$(tput setaf 196)"
  fi

  echo -e "${color_exit}[${exit}]$(tput sgr0)"
}

# Returns venv status, if enabled. Requires VIRTUAL_ENV_DISABLE_PROMPT
__prompt_venv_status__() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    echo -e "( ${VIRTUAL_ENV_PROMPT} $(python --version | cut -d ' ' -f 2)) "
  fi
}

PS1=""

# Exit status
PS1+='┌$(__prompt_exit_status__) '

# Username
PS1+='\[$(tput bold)\]\[$(tput setaf 45)\]'
PS1+='\u'
PS1+='\[$(tput sgr0)\]'

# Add "@hostname" if it is a remote connection
if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
  PS1+='\[$(tput setaf 159)\]'
  PS1+='@\h'
fi

PS1+=' '

# Path to workdir
PS1+='\[$(tput smul)\]\[$(tput setaf 155)\]'
PS1+='\w'
PS1+='\[$(tput rmul)\]'
PS1+=' '

# Git status
PS1+='\[$(tput setaf 214)\]'
PS1+='$(__prompt_git_status__)'

# venv status
PS1+='\[$(tput setaf 45)\]'
PS1+='$(__prompt_venv_status__)'

# End of prompt
PS1+='\[$(tput sgr0)\]\n'
PS1+='└─$ '

# Set window title
case "$TERM" in
xterm* | rxvt* | alacritty )
  PS1="\[\e]0;\u@\h: \w\a\]$PS1"
  ;;
*) ;;
esac
