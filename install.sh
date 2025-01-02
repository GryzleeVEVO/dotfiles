#!/usr/bin/env bash

# First, install yay
if ! command -v yay &>/dev/null; then
  sudo pacman -S --needed --noconfirm base-devel git
  temp_yay_dir=$(mktemp -d)
  git clone "https://aur.archlinux.org/yay-bin.git" "${temp_yay_dir}"
  cd "${temp_yay_dir}" || exit
  makepkg -si
  cd - || exit
  hash -r

  if ! command -v yay &>/dev/null; then
    echo "Something went wrong, couldn't install yay"
    exit 1
  fi

  unset temp_yay_dir

  echo -e "\nyay installed. Yay!!!!n"
else
  echo -e "\nyay already installed. Yay!!!!\n"
fi

core_packages=(
  base
  base-devel
  linux
  linux-firmware
  linux-headers
  amd-ucode
  efibootmgr
  os-prober
  grub

  # Man
  man-db
  man-pages

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

  openssh
  wget  # Download
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
  ly

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

yay -Syu --needed --noconfirm \
  "${core_packages[@]}" \
  "${audio_packages[@]}" \
  "${video_packages[@]}" \
  "${network_packages[@]}" \
  "${bluetooth_packages[@]}" \
  "${fs_packages[@]}" \
  "${printer_packages[@]}" \
  "${desktop_packages[@]}" \
  "${fonts_packages[@]}" \
  "${fancy_packages[@]}" \
  "${dev_packages[@]}"
