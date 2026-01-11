#!/bin/bash
# ───────────────────────────────────────────────
#  K A G E  (影)  -  LITE INSTALLER
#  Feudal Japan Neon Brutalism for Arch Linux VM
# ───────────────────────────────────────────────

set -e

echo "👺 KAGE INITIALIZING..."
echo ":: Installing Lite dependencies for VM..."

# 1. Install Packages (Arch Linux)
sudo pacman -S --needed --noconfirm \
    hyprland \
    waybar \
    alacritty \
    rofi \
    fastfetch \
    ttf-jetbrains-mono-nerd \
    thunar \
    feh \
    brightnessctl \
    playerctl \
    grim \
    slurp \
    wl-clipboard \
    pipewire \
    pipewire-pulse \
    wireplumber \
    kitty \
    sddm \
    qt5-quickcontrols2 \
    qt5-graphicaleffects \
    qt5-svg

# 2. Backup existing configs
echo ":: Backing up existing configs to ~/.config.kage-backup..."
mkdir -p ~/.config.kage-backup
mv ~/.config/hypr ~/.config.kage-backup/ 2>/dev/null || true
mv ~/.config/waybar ~/.config.kage-backup/ 2>/dev/null || true
mv ~/.config/alacritty ~/.config.kage-backup/ 2>/dev/null || true
mv ~/.config/rofi ~/.config.kage-backup/ 2>/dev/null || true

# 3. Link Configs
echo ":: Linking Kage configs..."
# Assumes script is queued from dotfiles root
DIR=$(pwd)

ln -sf "$DIR/hypr" ~/.config/hypr
ln -sf "$DIR/waybar" ~/.config/waybar
ln -sf "$DIR/rofi" ~/.config/rofi
# ln -sf "$DIR/neofetch" ~/.config/neofetch
mkdir -p ~/.config/fastfetch
ln -sf "$DIR/fastfetch/config.jsonc" ~/.config/fastfetch/config.jsonc

mkdir -p ~/.config/alacritty
ln -sf "$DIR/alacritty/alacritty.toml" ~/.config/alacritty/alacritty.toml

# 4. SDDM Theme Setup
echo ":: Setting up SSK (Samurai SDDM Kage)..."
if [ ! -d "/usr/share/sddm/themes/sugar-dark" ]; then
    echo "   Cloning Sugar Dark theme..."
    sudo git clone https://github.com/MarianArlt/sddm-sugar-dark.git /usr/share/sddm/themes/sugar-dark
fi

echo "   Configuring SDDM..."
sudo mkdir -p /etc/sddm.conf.d
echo "[Theme]
Current=sugar-dark" | sudo tee /etc/sddm.conf.d/theme.conf

sudo systemctl enable sddm

# 4. Cleanup
echo ":: Disabling conflicting services (if any)..."
# No heavy services installed in this lite version

echo "👺 KAGE INSTALLED."
echo "   Press SUPER + M to exit Hyprland if needed."
echo "   Restart Hyprland to apply changes."
