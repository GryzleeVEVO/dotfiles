# If not running interactively, don't run anything
[[ -z "$PS1" ]] && return

# Load aliases
unsetopt function_argzero
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"
setopt function_argzero

# Run antidote
if [[ -f "/usr/share/zsh-antidote/antidote.zsh" ]]; then
  source "/usr/share/zsh-antidote/antidote.zsh"
  antidote load
fi

# Use emacs keybindings
bindkey -e

# Set up VCS info
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%b%u) '
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' check-for-changes true

# Enable prompt substitutions
setopt prompt_subst

# Enable colors
autoload -U colors && colors

# Prompt: [x] user@host ~/path/to/dir (branch *) %
PROMPT='%(?.%F{10}.%F{9})[%?] '
PROMPT+='%F{14}%n'
[[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]] && PROMPT+='%\@%m'
PROMPT+='%F{4} %~ '
PROMPT+='%F{8}${vcs_info_msg_0_}'
PROMPT+='%f%% '

# Execute each time prompt is drawn
precmd() {
  vcs_info
}

# Enable completion
autoload -Uz compinit
compinit

HISTFILE="$HOME/.history" # History file
HISTORY_IGNORE=""         # Ignore these commands
SAVEHIST=50000            # History file size
HISTSIZE=10000            # History buffer size

setopt hist_ignore_all_dups # Don't store duplicates
setopt hist_reduce_blanks   # Remove superfluous blanks before adding to history
setopt inc_append_history   # Append to history file instead of overwriting
setopt hist_verify          # Don't execute history substitution immediately
setopt correct              # Command spelling correction
setopt globstarshort        # Enable extended globbing
setopt nocaseglob           # Case insensitive globbing
setopt autocd               # Automatically cd into directories

# Arrows
bindkey -e '^[[A' history-search-backward
bindkey -e '^[[B' history-search-forward
bindkey -e '^[[C' forward-char
bindkey -e '^[[D' backward-char

# Shift+Arrows
bindkey -e '^[[1;2C' forward-char
bindkey -e '^[[1;2D' backward-char

# Alt+Arrows
bindkey -e '^[[1;3C' forward-word
bindkey -e '^[[1;3D' backward-word

# Ctrl+Arrows
bindkey -e '^[[1;5C' forward-word
bindkey -e '^[[1;5D' backward-word
bindkey -e '^[[5C' forward-word
bindkey -e '^[[5D' backward-word
bindkey -e '^[^[C' forward-word
bindkey -e '^[^[D' backward-word

# Shift+Tab
bindkey '^[[Z' reverse-menu-complete

# Ctrl+Delete/Backspace
bindkey -e '^[[3;5~' kill-word
bindkey -e '^H' backward-kill-word

# Home/End
bindkey -e '^[[1~' beginning-of-line
bindkey -e '^[[4~' end-of-line

# Page Up/Down
bindkey -e '^[[5~' beginning-of-history
bindkey -e '^[[6~' end-of-history

# Insert/Delete
bindkey -e '^[[2~' quoted-insert
bindkey -e '^[[3~' delete-char

# Space: magic-space
bindkey -e ' ' magic-space

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{-_}={-}'    # Treat hyphens and underscores as equivalent
# setopt menu_complete                                # Tab cycles through completions
