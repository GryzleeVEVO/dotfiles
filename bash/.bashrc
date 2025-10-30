#
# .bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set -o vi                                                    # Use vi keybindings
stty -ixon -ixoff                                            # Disable tty flow (Ctrl-S/Ctrl-Q)
shopt -s cdspell                                             # Try to autocorrect misspelt directories
shopt -s checkwinsize                                        # Update LINES and COLUMNS after every command
shopt -s globstar                                            # Use ** to glob recursively
shopt -s histappend                                          # Append to history
shopt -s histreedit                                          # Don't clear prompt on failed substitution
shopt -s histverify                                          # Do not run commands on substitution
shopt -s no_empty_cmd_completion                             # Don't autocomplete for an empty prompt
shopt -s nocaseglob                                          # Case-insensitive glob
[[ "${BASH_VERSINFO[0]}" -ge 4 ]] && shopt -s autocd         # If command is a directory, cd into it
[[ "${BASH_VERSINFO[0]}" -ge 5 ]] && shopt -s progcomp_alias # Try to autocomplete for aliases

# History file
[[ -n "$XDG_CACHE_HOME" ]] &&
  HISTFILE="$XDG_CACHE_HOME/history" ||
  HISTFILE="$HOME/.history"

HISTFILESIZE=50000               # History file size
HISTSIZE=10000                   # History buffer size
HISTCONTROL=erasedups:ignoreboth # Don't store duplicates and extra whitespace

# Ignore 1-3 character commands, as well as some common commands
HISTIGNORE="?:??:???:clear:exit:quit:history"

# Append to history every time the prompt is redrawn
PROMPT_COMMAND="history -a"

# Custom prompt
[[ -f "$XDG_CONFIG_HOME/prompts/prompt.bash" ]] &&
  . "$XDG_CONFIG_HOME/prompts/prompt.bash"

# Custom aliases
for alias in "$XDG_CONFIG_HOME/aliases/"*; do
  [[ -f "$alias" ]] && . "$alias"
done

# Custom dircolors
[[ -f "$XDG_CONFIG_HOME/dircolors/dircolors" ]] && eval "$(dircolors "$XDG_CONFIG_HOME"/dircolors/dircolors)"

# Load completions
if command -v kubectl &>/dev/null; then
  source <(kubectl completion bash)
  complete -o default -F __start_kubectl k
fi

if command -v docker &>/dev/null; then
  source <(docker completion bash)
  complete -o default -F __start_docker d
fi

# Just to have #? set to 0
:
