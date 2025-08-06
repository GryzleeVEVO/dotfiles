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

zmodload -i zsh/complist                                       # Preload completion list
autoload -Uz compinit && compinit -d $XDG_CACHE_HOME/zcompdump # Enable autocompletion
zstyle ':completion:*' menu select                             # Menu completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}'  # Case and hyphen/underscore insensitive completion

# History file
[[ -n "$XDG_CACHE_HOME" ]] &&
    HISTFILE="$XDG_CACHE_HOME/history" ||
    HISTFILE="$HOME/.history"

SAVEHIST=50000 # History file size
HISTSIZE=10000 # History buffer size

# Ignore 1-3 character commands, as well as some common commands
HISTORY_IGNORE="(?|??|???|cls|clr|clear|quit|exit|history)"

# Faster mode switching in vi mode
export KEYTIMEOUT=1 # Faster

source_first_found() {
    for file in "$@"; do
        [[ -f "$file" ]] && source "$file" && return 0
    done
    return 1
}

# Load aliases
for alias in "$XDG_CONFIG_HOME/aliases/"*; do
    [[ -f "$alias" ]] && . "$alias"
done

# Load fish-like syntax highlighting
source_first_found \
    "$XDG_DATA_HOME/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
    "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Load fish-like autosuggestions
source_first_found \
    "$XDG_DATA_HOME/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" \
    "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Load completions for some programs
command -v fnm >&/dev/null && eval "$(fnm completions --shell zsh)"

unset -f source_first_found

command -v starship >&/dev/null && eval "$(starship init zsh)"
command -v opam &>/dev/null && eval "$(opam env)"
