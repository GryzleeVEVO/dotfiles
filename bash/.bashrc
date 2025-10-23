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

# Load prompt
[[ -f "$XDG_CONFIG_HOME/prompts/prompt.bash" ]] &&
  . "$XDG_CONFIG_HOME/prompts/prompt.bash"

# Load aliases
for alias in "$XDG_CONFIG_HOME/aliases/"*; do
  [[ -f "$alias" ]] && . "$alias"
done

# Load colours
[[ -f "$XDG_CONFIG_HOME/dircolors/dircolors" ]] && eval "$(dircolors "$XDG_CONFIG_HOME"/dircolors/dircolors)"

command -v fnm >&/dev/null && eval "$(fnm completions --shell bash)"

command -v opam >&/dev/null && eval "$(opam env)"

# Just to have #? set to 0
:
