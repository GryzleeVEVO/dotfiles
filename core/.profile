# ~/.profile

################################################################################
# Path and directories                                                         #
################################################################################

# ------------------------------------------------------------------------------
# XDG directories
# ------------------------------------------------------------------------------
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# ------------------------------------------------------------------------------
# Docker                                                                       |
# ------------------------------------------------------------------------------
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

# ------------------------------------------------------------------------------
# GTK                                                                          |
# ------------------------------------------------------------------------------
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"

# ------------------------------------------------------------------------------
# Node.js/NPM/NVM                                                              |
# ------------------------------------------------------------------------------
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NODE_REPL_HISTORY="$XDG_CACHE_HOME/node_repl_history"
export NVM_DIR="$XDG_DATA_HOME/nvm"

# ------------------------------------------------------------------------------
# Readline
# ------------------------------------------------------------------------------
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"

# ------------------------------------------------------------------------------
# Path
# ------------------------------------------------------------------------------
export PATH="$HOME/.local/bin:$PATH"

################################################################################
# Configuration                                                                #
################################################################################

# Use qt6ct as the QPA
export QT_QPA_PLATFORMTHEME="qt6ct"

# Do not add venv info to prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

################################################################################
# Default apps                                                                 #
################################################################################

if command -v nvim &>/dev/null; then
	export EDITOR='nvim'
else
	export EDITOR='vim'
fi

export PAGER='less'

if command -v google-chrome-stable &>/dev/null; then
	export BROWSER='google-chrome-stable'
fi

################################################################################
# Load bashrc (if login is bash)                                               #
################################################################################

if [ -n "$BASH_VERSION" ]; then
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi
