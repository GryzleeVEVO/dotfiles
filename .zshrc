#   
#    ####             ####
#   ######           ######         zsh 
#    ####             ####          config file
#
#   ########################        gryzlee
#    ######################
#     ###################	    Note: requires oh-my-zsh
#       ################       
#

# ================= OH-MY-ZSH =================

# Enable Powerlevel10k instant prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
	git
	zsh-autosuggestions
	sudo
)

# Updates
zstyle ':omz:update' mode disabled
DISABLE_AUTO_UPDATES=true
DIABLE_UPDATE_PROMPT=true

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ================= User configuration =================

# ----------------- SSH -----------------

eval $(ssh-agent) >> /dev/null
ssh-add -q ~/.credentials/.*.priv 

# ----------------- ALIASES -----------------

setopt complete_aliases

# Dotfile managment (tracks dotfiles in bare repo)
alias dotmgr='/usr/bin/git --git-dir=$HOME/.dotmgr/ --work-tree=$HOME'
compdef dotmgr='git'

# Quick access to config files
config () {
	dotfile_path=""
	case "$1" in
		alacritty) dotfile_path="$HOME/.config/alacritty/alacritty.yml"
			;;
		i3) dotfile_path="$HOME/.config/i3/config" 
			;;
		i3status) dotfile_path="$HOME/.config/i3/i3status.conf"
			;;
		picom) dotfile_path="$HOME/.config/picom/picom.conf"
			;;
		polybar) dotfile_path="$HOME/.config/polybar/config.ini"
			;;
		bash) dotfile_path="$HOME/.bashrc"
			;;
		zsh) dotfile_path="$HOME/.zshrc"
			;;
		*) echo "Specified program not set as configurable" && return 1
			;;
	esac
	[ -n "$dotfile_path" -a -f "$dotfile_path" ] && nvim "$dotfile_path" && return 0
	echo "Path to dotfile invalid" && return 1
}


