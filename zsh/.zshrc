# zshrc

[[ -z "$PS1" ]] && return # If not running interactively, don't run anything

# Source aliases
[[ -f "$HOME/.bash_aliases" ]] && source "$HOME/.bash_aliases"

# * ANTIDOTE (Plugin manager)
source "/usr/share/zsh-antidote/antidote.zsh"
antidote load


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
PROMPT+='%F{192} %~ '                    # pwd
PROMPT+='%F{226}${vcs_info_msg_0_}'      # (branch *)
PROMPT+='%f$ '                           # $

precmd() {
    vcs_info # Update VCS info
}

# * HISTORY

[[ -n "${key[Up]}" ]] && bindkey -- "${key[Up]}" history-substring-search-up 
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" history-substring-search-down

