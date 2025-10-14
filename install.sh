#!/bin/bash

# Exit on error and undefined variables
set -eu

# Create necessary directories
mkdir -p ~/.config ~/Pictures ~/.local/share/rofi/themes

sudo pacman -S git wget firefox rofi hyprland waybar kitty kate sddm nwg-look gnome-themes-extra papirus-icon-theme

sudo systemctl enable sddm

cp -r hypr ~/.config
cp -r waybar ~/.config
cp -r kitty ~/.config

git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

paru -Syu
paru -Suy
paru -Su
paru -Sy

paru -S mpvpapaer flclash


# Download wallpaper
cd ~/Pictures
wget -O gray_bg.html "https://livewallpapers4free.com/download/19154/"
