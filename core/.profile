# Export SSH Agent socket
#export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket

# Added by Toolbox App
#export PATH="$PATH:/home/gryzlee/.local/share/JetBrains/Toolbox/scripts"

# Default apps

if command -v nvim &>/dev/null; then
    export EDITOR='nvim'
else
    export EDITOR='vim'
fi

export PAGER='less'

if command -v google-chrome-stable &>/dev/null; then
    export BROWSER='google-chrome-stable'
fi

#if command -v keepassxc &>/dev/null; then
#secret-tool lookup keepass credentials | keepassxc --pw-stdin $HOME/.secret/passwordsDb.kdbx &
#fi
