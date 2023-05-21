

autoload -Uz vcs_info compinit

compinit
setopt prompt_subst
zstyle ':vcs_info:*' formats '(%b %u)'
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' check-for-changes true
precmd() { vcs_info }

COLOR_BLUE1="%F{39}"
COLOR_BLUE2="%F{45}"
COLOR_BLUE3="%F{51}"
COLOR_GREEN="%F{192}"
COLOR_YELLOW="%F{226}"
COLOR_RESET="%f"

export PS1='$COLOR_BLUE1%n$COLOR_BLUE2@$COLOR_BLUE3%m$COLOR_GREEN %~$COLOR_YELLOW${vcs_info_msg_0_}$COLOR_RESET $ '


