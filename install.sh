#!/usr/bin/env bash

# OBJECTIVES
# - Install packages
#
# - Stow dotfiles
#   - Need stow for that
#   - What modules to install?
#   - How to handle files already present
#
# - Install etc files
#
# - Start services

core_packages=(
  # Pacman
  pacman-contrib
  pkgfile
  reflector # Check for fastest mirror

  acpilight # Use ACPI for brightness control

  # Tools
  bc
  fastfetch
  htop
  imagemagick # Convert image formats
  sudo
  tealdeer # tl;dr pages
  tlp      # Power management
  zip
  unzip

  # Shells
  bash-completion
  zsh
  zsh-autosuggestions
  zsh-completions
  zsh-syntax-highlighting
)

audio_packages=(
  pipewire
  pipewire-alsa
  pipewire-jack
  pipewire-pulse

  playerctl # Control media playback from terminal
)

video_packages=(
  # AMD
  mesa
  mesa-utils
  vulkan-radeon

  # Nvidia
  nvidia
  nvidia-prime
  libva-nvidia-driver
  envycontrol

  nvtop # Top for graphics cards
)

network_packages=(
  networkmanager

  # openssh
  # wget  # Download
  whois # Query DNS
  wol   # Wake-on-lan
)

bluetooth_packages=(
  bluez
  bluez-utils
)

fs_packages=(
  cifs-utils # Samba support
  ntfs-3g    # NTFS support
  rsync      # Incremental file transfers
  udisks2
  udiskie # Automounting daemon
)

printer_packages=(
  cups       # Printer backend
  gutenprint # Printer drivers
  sane       # Scanner backend
)

fonts_packages=(
  adobe-source-sans-fonts
  noto-fonts-cjk
  noto-fonts-emoji
  noto-fonts-extra
  ttc-iosevka
  ttf-dejavu
  ttf-fira-code
  ttf-fira-mono
  ttf-fira-sans
  ttf-inconsolata
  ttf-jetbrains-mono
  ttf-jetbrains-mono-nerd
  ttf-noto-nerd
  ttf-roboto
  ttf-roboto-mono
  ttf-ubuntu-font-family
)

fancy_packages=(
  capitaine-cursors
  papirus-icon-theme
  qt6ct
)

desktop_packages=(
  # Xorg
  xorg-server
  xorg-xinit
  xorg-xrandr
  xclip

  # Display manager
  # ly
  sddm
  qt6-5compat
  qt6-multimedia

  # i3 and tools
  arandr
  autorandr
  batsignal
  blueman
  caffeine-ng
  dex
  dunst
  gnome-keyring
  i3-wm
  i3blocks
  i3lock-color
  i3status
  nitrogen
  pavucontrol
  picom
  polybar
  rofi
  xdg-desktop-portal-gtk
  xss-lock

  # Apps
  alacritty
  autotiling
  discord
  eog
  evince
  firefox
  gnome-calculator
  gnome-font-viewer
  gnome-screenshot
  gnome-themes-extra
  gpick
  keepassxc
  qbittorrent
  simple-scan
  vlc
)

dev_packages=(
  fzf
  git
  ripgrep
  tmux
  ranger

  # Editors
  neovim
  jetbrains-toolbox
  visual-studio-code-bin

  # C/C++
  clang
  cmake
  gcc
  gdb
  ninja

  ghcup-hs-bin
  go
  jdk-openjdk
  luarocks
  npm
  python-pipx # Install python apps directly from pip
  rustup

  # Virtualization
  docker
  docker-compose
  qemu-base
)

export selected_profile
export install_etc=0

parse_args() {
  # https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash
  while [[ $# -gt 0 ]]; do
    case $1 in
    "-p" | "--profile")
      selected_profile="$2"
      shift 2
      ;;
    "-e" | "--etc")
      install_etc=1
      shift
      ;;
    "--*" | "-*")
      echo "ERR: Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1")
      shift 1
      ;;
    esac
  done
}

install_yay() {
  if ! command -v yay &>/dev/null; then
    echo -e "\n### INSTALLING YAY DEPENDENCIES (needs privileges) ###\n"
    sudo pacman -S --needed --noconfirm base-devel git
    hash -r

    echo -e "\n### INSTALLING YAY ###\n"
    temp_yay_dir=$(mktemp -d)
    git clone "https://aur.archlinux.org/yay-bin.git" "${temp_yay_dir}"
    cd "${temp_yay_dir}" || exit 60
    makepkg -si
    hash -r
    cd - || exit 60
  else
    echo -e "\n### YAY ALREADY INSTALLED ###\n"
  fi
}

install_packages() {
  install_optional_packages() {
    echo
    read -p "Need $1? [y/n]" -n 1 -r
    echo
    shift

    if [[ $REPLY =~ ^[Yy]$ ]]; then
      yay -S --needed --noconfirm "$@"
    fi
  }

  case ${selected_profile} in
  "core")
    yay -S --needed --noconfirm \
      "${core_packages[@]}" \
      "${network_packages[@]}" \
      "${fs_packages[@]}" \
      "${dev_packages[@]}"
    ;;
  "desktop")
    yay -S --needed --noconfirm \
      "${core_packages[@]}" \
      "${network_packages[@]}" \
      "${fs_packages[@]}" \
      "${audio_packages[@]}" \
      "${video_packages[@]}" \
      "${desktop_packages[@]}" \
      "${fonts_packages[@]}" \
      "${fancy_packages[@]}"

    install_optional_packages "bluetooth" "${bluetooth_packages[@]}"
    install_optional_packages "a printer/scanner" "${printer_packages[@]}"
    ;;
  *) echo "WARN: Unknown profile, ignoring" ;;
  esac
}

install_stow() {
  if ! command -v stow &>/dev/null; then
    echo -e "\n### INSTALLING STOW ###\n"
    yay -S --needed --noconfirm stow
    hash -r
  else
    echo -e "\n### STOW ALREADY INSTALLED ###\n"
  fi
}

install_dotfiles() {
  install_stow

  install_dotfile_packages() {
    if stow -nvt "${HOME}" "$@"; then
      stow -vt "${HOME}" "$@" && echo -e "\n### PACKAGES INSTALLED ###\n"
    else
      echo -e "\n### FAILED TO INSTALL PACKAGES ###\n"
    fi
  }

  case ${selected_profile} in
  "core") install_dotfile_packages core bash zsh ;;
  "desktop") install_dotfile_packages core bash zsh neovim desktop ;;
  *) echo "WARN: Unknown profile, ignoring" ;;
  esac

}

install_etc_files() {
  echo "NOT IMPLEMENTED"
}

start_systemd_services() {
  echo "NOT IMPLEMENTED"
}

parse_args "$@"

# Always check for yay first
install_yay

install_dotfiles
install_packages

[[ ${install_etc} -ne 0 ]] && install_etc_files
