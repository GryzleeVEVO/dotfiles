#   
#    ####             ####
#   ######           ######         zsh 
#    ####             ####          config file
#
#   ########################        gryzlee
#    ######################
#     ###################			Note: requires oh-my-zsh
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

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh



# ================= User configuration =================

# ----------------- ALIASES -----------------

# Dotfile managment (tracks dotfiles in bare repo)
alias dotmgr='/usr/bin/git --git-dir=$HOME/.dotmgr/ --work-tree=$HOME'
