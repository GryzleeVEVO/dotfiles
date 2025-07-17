# Set default XDG directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# https://wiki.archlinux.org/title/XDG_Base_Directory
# Some apps don't respect the XDG Base Directory specification but can be forced to use it
# Others it is either messy, buggy or impossible, and not worth the effort
# This is not an exhaustive list

# Android SDK
export ANDROID_HOME="$XDG_DATA_HOME/Android/Sdk"
export ANDROID_USER_HOME="$XDG_DATA_HOME/Android"

# Docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

# Dotnet
export DOTNET_CLI_HOME="$XDG_DATA_HOME/dotnet"
export NUGET_PACKAGES="$XDG_CACHE_HOME/NuGetPackages"
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Golang
export GOPATH="$XDG_DATA_HOME/go"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"

# GTK
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"

# Haskell
export GHCUP_USE_XDG_DIRS=1
export STACK_XDG=1

# Java
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"

# JetBrains
export PATH="$PATH:$XDG_DATA_HOME/JetBrains/Toolbox/scripts"

# Kubernetes
export KUBECONFIG="$XDG_CONFIG_HOME/kube"
export KUBECACHEDIR="$XDG_CACHE_HOME/kube"

# Less
export LESSHISTFILE="$XDG_CACHE_HOME/lesshst"

# Node JS
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NODE_REPL_HISTORY="$XDG_CACHE_HOME/node_repl_history"
export NVM_DIR="$XDG_DATA_HOME/nvm"
export FNM_PATH="/home/gryzlee/.local/share/fnm"
export PATH="$PATH:$FNM_PATH"

if command -v fnm >&/dev/null; then
	eval "$(fnm env)"
fi

# Nvidia
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"

# GNU Parallel
export PARALLEL_HOME="$XDG_CONFIG_HOME/parallel"

# Python (note: maybe substitute pyenv for UV)
export VIRTUAL_ENV_DISABLE_PROMPT=1
export PYTHON_HISTORY="$XDG_CACHE_HOME/python_history" # For Python >= 3.13
export PYENV_ROOT="$HOME/.local/share/pyenv"
export PATH="$PATH:$PYENV_ROOT/bin"

if command -v pyenv >&/dev/null; then
	eval "$(pyenv init -)"
fi

# Qt
export QT_QPA_PLATFORMTHEME="qt6ct"

# Readline
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"

# Rust
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"

# Texlive
export PATH="$PATH:/usr/local/texlive/2025/bin/x86_64-linux"
export MANPATH="$MANPATH:/usr/local/texlive/2025/texmf-dist/doc/man"

# Add path for user bins. Takes priority over any other path
export PATH="$HOME/.local/bin:$PATH"

# Default programs
export EDITOR='nvim'
export BROWSER='firefox'
export PAGER='less'

# Load bashrc in case login is also interactive
[ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
