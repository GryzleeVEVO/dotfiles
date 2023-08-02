# .zshrc

# If not running interactively, don't run anything
[[ -z "$PS1" ]] && return

# Source aliases (only if on Linux)
if [[ -f "$HOME/.bash_aliases" ]] && [ "$(uname)" = "Linux" ]; then
    source "$HOME/.bash_aliases"
fi

# Antidote (Plugin manager)
source "/usr/share/zsh-antidote/antidote.zsh"
antidote load

# PROMPT

autoload -Uz vcs_info # Load and enable version control info

zstyle ':vcs_info:*' formats '(%b %u) ' # Sets up version control info
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' check-for-changes true

setopt prompt_subst # Enable prompt expansion

PROMPT='%(?.%F{green}[%?].%F{red}[%?]) ' # [exit code]
PROMPT+='%F{39}%n'                       # user
PROMPT+='%F{45}@'                        # @
PROMPT+='%F{51}%m'                       # host
PROMPT+='%F{192} %~ '                    # pwd
PROMPT+='%F{226}${vcs_info_msg_0_}'      # (branch *)
PROMPT+='%f$ '                           # $

precmd() {
    vcs_info # Update VCS info
}

# COMPLETION

autoload -Uz compinit
compinit

# HISTORY

HISTFILE="$HOME/.history" # History file
SAVEHIST=50000
HISTSIZE=10000 # Size of current history buffer

setopt inc_append_history
setopt hist_ignore_all_dups
