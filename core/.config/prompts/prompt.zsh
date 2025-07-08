#!/usr/bin/env zsh

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
