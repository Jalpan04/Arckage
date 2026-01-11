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
    foot \
    fish \
    sddm \
    qt5-quickcontrols2 \
    qt5-graphicaleffects \
    qt5-svg \
    dolphin \
    qt5ct \
    breeze-icons \
    archlinux-wallpaper

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

mkdir -p ~/.config/foot
ln -sf "$DIR/foot/foot.ini" ~/.config/foot/foot.ini

# mkdir -p ~/.config/alacritty
# ln -sf "$DIR/alacritty/alacritty.toml" ~/.config/alacritty/alacritty.toml

# 5. Fish Shell Setup
echo ":: Setting Fish as default shell..."
sudo chsh -s /usr/bin/fish $USER

# 6. SDDM Theme Setup
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

# 7. System Polish (Hostname & Theming)
echo ":: Setting Hostname to 'archkage'..."
sudo hostnamectl set-hostname archkage

echo ":: Configuring Dark GTK/Qt Themes..."
# GTK3
mkdir -p ~/.config/gtk-3.0
echo "[Settings]
gtk-application-prefer-dark-theme=1
gtk-theme-name=Adwaita-dark
gtk-icon-theme-name=Adwaita
gtk-font-name=JetBrainsMono Nerd Font 11" > ~/.config/gtk-3.0/settings.ini

# Qt5 (for Dolphin)
echo "export QT_QPA_PLATFORMTHEME=qt5ct" >> ~/.profile

# 4. Cleanup
echo ":: Disabling conflicting services (if any)..."
# No heavy services installed in this lite version

echo "👺 KAGE INSTALLED."
echo "   Press SUPER + M to exit Hyprland if needed."
echo "   Restart Hyprland to apply changes."
