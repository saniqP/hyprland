#!/bin/bash

# Exit on error and undefined variables
set -eu

# Create necessary directories
mkdir -p ~/.config ~/Pictures ~/.local/share/rofi/themes

# Download wallpaper
cd ~/Pictures
wget -O gray_bg.html "https://livewallpapers4free.com/download/19154/" || {
    echo "Failed to download wallpaper, continuing..."
}

# Install packages
sudo pacman -S --needed --noconfirm zsh wget hyprland waybar kitty rofi nemo

# Copy configuration files
cp -r {kitty,hypr,waybar} ~/.config/ 2>/dev/null || echo "Some config folders not found, continuing..."
cp -r .zshrc ~/ 2>/dev/null || echo ".zshrc not found, continuing..."

# Install Oh My Zsh (if not already installed)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install zsh syntax highlighting
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
mkdir -p "$ZSH_CUSTOM/plugins"
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# Set zsh as default shell
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)"
    echo "Zsh set as default shell. Please log out and log back in."
fi

echo "Installation completed!"
