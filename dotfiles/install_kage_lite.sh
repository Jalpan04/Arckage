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
    kvantum \
    breeze-icons \
    firefox \
    hyprpaper \
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

# Link Hyprland
ln -sf "$DIR/hypr" ~/.config/hypr

# Link Wallpapers
mkdir -p ~/.config/wallpapers
ln -sf "$DIR/wallpapers/kage_wall.jpg" ~/.config/wallpapers/kage_wall.jpg

# Link Hyprpaper
ln -sf "$DIR/hypr/hyprpaper.conf" ~/.config/hypr/hyprpaper.conf

# Link Waybar
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
# QT5CT (Dolphin Kage Theme)
mkdir -p ~/.config/qt5ct/colors
ln -sf "$DIR/qt5ct/qt5ct.conf" ~/.config/qt5ct/qt5ct.conf
ln -sf "$DIR/qt5ct/colors/Kage.conf" ~/.config/qt5ct/colors/Kage.conf
export QT_QPA_PLATFORMTHEME=qt5ct

# Kvantum (Better Qt Theming)
echo ":: Setting up Kvantum..."
mkdir -p ~/.config/Kvantum
echo "[General]
theme=KvAdaptaDark" > ~/.config/Kvantum/kvantum.kvconfig

# GTK3
# GTK3
mkdir -p ~/.config/gtk-3.0
echo "[Settings]
gtk-application-prefer-dark-theme=1
gtk-theme-name=Adwaita-dark
gtk-icon-theme-name=Adwaita
gtk-font-name=JetBrainsMono Nerd Font 11" > ~/.config/gtk-3.0/settings.ini

# Qt5 (for Dolphin)
echo "export QT_QPA_PLATFORMTHEME=qt5ct" >> ~/.profile

# Firefox Dark Theme (userChrome.css)
echo ":: Configuring Firefox Dark Theme..."
# We need to find the profile folder. This is tricky if FF hasn't run.
# We'll create a default profile if it doesn't exist.
if [ ! -d ~/.mozilla/firefox ]; then
    firefox --headless --screenshot google.com 2>/dev/null &
    FF_PID=$!
    sleep 5
    kill $FF_PID
fi

FF_PROFILE=$(find ~/.mozilla/firefox -maxdepth 1 -type d -name "*.default-release" | head -n 1)
if [ -z "$FF_PROFILE" ]; then
    FF_PROFILE=$(find ~/.mozilla/firefox -maxdepth 1 -type d -name "*.default" | head -n 1)
fi

if [ -n "$FF_PROFILE" ]; then
    echo "   Found profile: $FF_PROFILE"
    mkdir -p "$FF_PROFILE/chrome"
    
    # Enable userChrome.css
    echo 'user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);' >> "$FF_PROFILE/user.js"
    echo 'user_pref("browser.compactmode.show", true);' >> "$FF_PROFILE/user.js"
    echo 'user_pref("browser.uidensity", 1);' >> "$FF_PROFILE/user.js"

    # Write CSS
    echo '/* KAGE - Firefox Dark Mode */
:root {
  --toolbar-bgcolor: #000000 !important;
  --tab-selected-bgcolor: #ffcc00 !important;
  --tab-selected-textcolor: #000000 !important;
  --chrome-content-separator-color: #ff0033 !important;
  --lwt-text-color: #00ffff !important;
}
#navigator-toolbox { background-color: #000000 !important; border-bottom: 2px solid #ff0033 !important; }
.tab-background[selected="true"] { background: #ffcc00 !important; }
.tab-label[selected="true"] { color: #000000 !important; font-weight: bold !important; }
' > "$FF_PROFILE/chrome/userChrome.css"
    echo "   Applied userChrome.css"
else
    echo "   WARNING: Could not find Firefox profile. Run Firefox once and re-run script."
fi

# 4. Cleanup
echo ":: Disabling conflicting services (if any)..."
# No heavy services installed in this lite version

echo "👺 KAGE INSTALLED."
echo "   Press SUPER + M to exit Hyprland if needed."
echo "   Restart Hyprland to apply changes."
