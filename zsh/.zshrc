# zshrc

# If not running interactively, don't run anything
[[ -z "$PS1" ]] && return

# *** PROMPT ***

# Prompt variable
PROMPT_USER='%n'
PROMPT_HOST='%m'
PROMPT_DIR='%~'

# Colors
COLOR_39='%F{39}'
COLOR_45='%F{45}'
COLOR_51='%F{51}'
COLOR_192='%F{192}'
COLOR_226='%F{226}'
COLOR_RESET='%f'

# Load and enable version control info
autoload -Uz vcs_info

# Sets up version control info
zstyle ':vcs_info:*' formats '(%b %u)'
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' check-for-changes true

# Enable prompt expansion
setopt prompt_subst

# Format:
# user@host /.../path/to/dir (branch *) $
PROMPT='${COLOR_39}${PROMPT_USER}'
PROMPT+='${COLOR_45}@'
PROMPT+='${COLOR_51}${PROMPT_HOST} '
PROMPT+='${COLOR_192}${PROMPT_DIR} '
PROMPT+='${COLOR_226}${vcs_info_msg_0_}'
PROMPT+='${COLOR_RESET} $ '

precmd() {
    vcs_info
}

completion_setup() {
    # Load and enable command completion
    autoload -Uz compinit
    compinit
}

completion_setup
