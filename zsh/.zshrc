# If not running interactively, don't run anything
[[ -z "$PS1" ]] && return

# Antidote (Plugin manager)
setopt function_argzero
source "/usr/share/zsh-antidote/antidote.zsh"
antidote load

# Source aliases (only if on Linux)
unsetopt function_argzero
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Use emacs keybindings
bindkey -e

# Set up VCS info
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%b%u) '
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' check-for-changes true

# Enable prompt substitutions
setopt prompt_subst

# Prompt: [x] user@host ~/pwd (branch *) $
PROMPT='%(?.%F{green}.%F{red})[%?] '
PROMPT+='%F{39}%n'
PROMPT+='%F{45}@'
PROMPT+='%F{51}%m'
PROMPT+='%F{192} %~ '
PROMPT+='%F{226}${vcs_info_msg_0_}'
PROMPT+='%f$ '

# Execute each time prompt is drawn
precmd() {
  vcs_info
}

# Enable completion
autoload -Uz compinit
compinit

# History file
HISTFILE="$HOME/.history"

# Commands to ignore in history
HISTORY_IGNORE=""

# History size
SAVEHIST=50000

# Size of history in memory
HISTSIZE=10000

# Erase duplicates
setopt hist_ignore_all_dups

# Trim whitespaces
setopt hist_reduce_blanks

# Append immediately to history file
setopt inc_append_history

# Don't execute immediately upon history expansion
setopt histverify

# Autocorrect typos
setopt correct

# Case-insensitive globbing
setopt nocaseglob

# cd into directories by typing their name
setopt autocd
