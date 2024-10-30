# Set default XDG directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# https://wiki.archlinux.org/title/XDG_Base_Directory
# Some apps don't respect the XDG Base Directory specification but can be forced to use it
# Others it is either messy, buggy or impossible, and not worth the effort
# This is not an exhaustive list

export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

export DOTNET_CLI_HOME="${XDG_DATA_HOME}/dotnet"
export NUGET_PACKAGES="$XDG_CACHE_HOME/NuGetPackages"

export GOPATH="$XDG_DATA_HOME/go"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"

export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"

export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NODE_REPL_HISTORY="$XDG_CACHE_HOME/node_repl_history"
export NVM_DIR="$XDG_DATA_HOME/nvm"

export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"

export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"

export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"

# Add path for user bin
export PATH="$HOME/.local/bin:$PATH"

# Disable dotnet telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Use qt6ct as the QPA
export QT_QPA_PLATFORMTHEME="qt6ct"

# Don't show Python's venv prompt when activated
# TOOD: Add custom venv prompt?
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Default programs
export EDITOR='nvim'
export BROWSER='firefox'
export PAGER='less'

# Load bashrc in case login is also interactive
[ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
