#
# .zshrc
#

# If not running interactively, don't run anything
[[ -z "$PS1" ]] && return

# # Use vi mode. Mapping is configured at the end
# export KEYTIMEOUT=1

bindkey -v                    # Use vi keybindings
stty -ixon -ixoff             # Disable tty flow (Ctrl-S/Ctrl-Q)
setopt hist_ignore_all_dups   # Don't store dupliactes
setopt hist_ignore_space      # Don't save lines starting with whitespace
setopt hist_reduce_blanks     # Trim extra whitespace
setopt inc_append_history     # Append to history
setopt hist_verify            # Do not run commands on substitution
setopt correct                # Suggest spelling correction for commands
setopt autocd                 # If command is a directory, cd into it
setopt auto_pushd             # Push directory to stack on cd
setopt cdable_vars            # Allow using variables as directories for cd
setopt cd_silent pushd_silent # Do not print directory on cd or pushd/popd
setopt globstarshort          # ** always searches recursively
setopt nocaseglob             # Case-insensitive glob
setopt nomatch                # Fail on no match for glob

zmodload -i zsh/complist                                      # Preload completion list
autoload -Uz compinit && compinit                             # Enable autocompletion
zstyle ':completion:*' menu select                            # Menu completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' # Case and hyphen/underscore insensitive completion

# History file
[[ -n "$XDG_CACHE_HOME" ]] &&
    HISTFILE="$XDG_CACHE_HOME/history" ||
    HISTFILE="$HOME/.history"

SAVEHIST=50000 # History file size
HISTSIZE=10000 # History buffer size

# Ignore 1-3 character commands, as well as some common commands
HISTORY_IGNORE="(?|??|???|cls|clr|clear|quit|exit|history)"

# Faster mode switching in vi mode
export KEYTIMEOUT=1

# # Enable colors
# autoload -U colors && colors
#
# # Enable prompt substitutions
# setopt prompt_subst
#
# # Set up VCS info
# autoload -Uz vcs_info
# zstyle ':vcs_info:*' formats '(%b%u) '
# zstyle ':vcs_info:*' unstagedstr ' *'
# zstyle ':vcs_info:*' check-for-changes true
#
# # Prompt: [x] user@host ~/path/to/dir (branch *) %                          MODE
# PS1='%(?.%F{10}.%F{9})[%?] '
# PS1+='%F{14}%n'
# [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]] && PROMPT+='%\@%m'
# PS1+='%F{4} %~ '
# PS1+='%F{8}${vcs_info_msg_0_}'
# PS1+='%f%% '
#
# # Execute each time prompt is redrawn
# precmd() {
#     vcs_info
# }

# Colorize directories
# Colorize completion prefix
#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
#zstyle -e ':completion:*' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==35}")';

################################################################################
# KEY BINDINGS                                                                 #
################################################################################

# Load aliases
for alias in "$XDG_CONFIG_HOME/aliases/"*; do
    [[ -f "$alias" ]] && . "$alias"
done

# Load syntax highlighting
if [[ -f $XDG_DATA_HOME/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source $XDG_DATA_HOME/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Load autosuggestions
if [[ -f $XDG_DATA_HOME/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source $XDG_DATA_HOME/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Load completions for some programs
if command -v fnm >&/dev/null; then
    eval "$(fnm completions --shell zsh)"
fi
