# zshrc

[[ -z "$PS1" ]] && return # If not running interactively, don't run anything

# Source aliases
[[ -f "$HOME/.bash_aliases" ]] && source "$HOME/.bash_aliases"

# Source plugins
#if [[ -f "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh" ]]; then
#    source "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
#fi

#if [[ -f "/usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh" ]]; then
#    source "/usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
#fi

# * PROMPT

autoload -Uz vcs_info # Load and enable version control info

zstyle ':vcs_info:*' formats '(%b %u) ' # Sets up version control info
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' check-for-changes true

setopt prompt_subst # Enable prompt expansion

PROMPT='%(?.%F{green}[%?].%F{red}[%?]) ' # [exit code]
PROMPT+='%F{39}%n'                       # user
PROMPT+='%F{45}@'                        # @
PROMPT+='%F{51}%m'                       # host
PROMPT+='%F{192}% ~ '                    # pwd
PROMPT+='%F{226}${vcs_info_msg_0_}'      # (branch *)
PROMPT+='%f$ '                           # $

precmd() {
    vcs_info # Update VCS info
}

# * HISTORY

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}" ]] && bindkey -- "${key[Up]}" up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

# * AUTOCOMPLETE/EXPANSION

# Autocompletion

# autoload -Uz compinit
# compinit
#
# zstyle ':completion:*' menu select
