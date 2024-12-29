#
# .zshrc
#

# If not running interactively, don't run anything
[[ -z "$PS1" ]] && return

# Load aliases
# .aliases needs $0 to be the name of the shell
unsetopt function_argzero

for alias in "$XDG_CONFIG_HOME/aliases/"*; do
  [[ -f "$alias" ]] && source "$alias"
done

setopt function_argzero


# # Use vi mode
# bindkey -v
# export KEYTIMEOUT=1

################################################################################
# PROMPT                                                                       #
################################################################################

# Enable colors
autoload -U colors && colors

# Enable prompt substitutions
setopt prompt_subst

# Set up VCS info
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%b%u) '
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' check-for-changes true

# Prompt: [x] user@host ~/path/to/dir (branch *) %                          MODE
PS1='%(?.%F{10}.%F{9})[%?] '
PS1+='%F{14}%n'
[[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]] && PROMPT+='%\@%m'
PS1+='%F{4} %~ '
PS1+='%F{8}${vcs_info_msg_0_}'
PS1+='%f%% '

# Execute each time prompt is redrawn
precmd() {
    vcs_info
}

################################################################################
# HISTORY                                                                      #
################################################################################

# History file
HISTFILE="$XDG_CACHE_HOME/.history"

# Don't store these commands
HISTORY_IGNORE="(c|cls|clr|clear|quit|q|exit|history|l|ls|ll|cd|pwd)"

# History file size
SAVEHIST=50000

# History buffer size
HISTSIZE=10000

# Don't store duplicates by removing the older one
setopt hist_ignore_all_dups

# Remove superfluous blanks before adding to history
setopt hist_reduce_blanks

# Append to history file instead of overwriting
setopt inc_append_history

# Don't execute history expansion immediately
setopt hist_verify

################################################################################
# COMPLETION, AUTOCOMPLETION AND SPELLING                                      #
################################################################################

# Enable completion
autoload -Uz compinit
compinit
zmodload -i zsh/complist

# Use menu completion
zstyle ':completion:*' menu select

# Case-insensitive completion
# Treat hyphens and underscores as equal
#zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}'

# Colorize directories
# Colorize completion prefix
#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
#zstyle -e ':completion:*' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==35}")';

# Suggest spelling corrections for commands
setopt correct

################################################################################
# DIRECTORY NAVIGATION                                                         #
################################################################################

# Automatically cd into directories
setopt autocd

# Automatically push directories onto the stack
setopt auto_pushd

# Enable cd'ing using variables
setopt cdable_vars

# Don't print directory after cd'ing or popping a directory from the stack
setopt cd_silent pushd_silent

################################################################################
# EXPASION AND GLOBBING                                                        #
################################################################################

# Enable extended globbing
setopt globstarshort

# Case insensitive globbing
setopt nocaseglob

# Throw an error if a glob doesn't match anything
setopt nomatch

################################################################################
# KEY BINDINGS                                                                 #
################################################################################

# # Disable terminal output control (Ctrl+S and Ctrl+Q)
# stty -ixon
#
# # Use vim keybindings to navigate suggestions
# zmodload zsh/complist
# bindkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'l' vi-forward-char
# bindkey -M menuselect 'j' vi-down-line-or-history

if [[ -f "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] ; then
     source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
