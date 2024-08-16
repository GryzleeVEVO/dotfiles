# Load profile
emulate sh
[ -f "$HOME/.profile" ] && . "$HOME/.profile"
emulate zsh

# Load .zshrc
[ -f "$HOME/.zshrc" ] && . "$HOME/.zshrc"
