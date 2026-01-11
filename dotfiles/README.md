# KAGE (影) - Arch Linux Rice

> **"Smool" Feudal Japan Neon Brutalism**

A high-contrast, text-centric Hyprland theme designed for focus and speed.
Inspired by the **Dionysus** rice by Pewdiepie-Archdaemon.

![Kage Theme](./dotfiles/wallpapers/kage_wall.jpg)

## 🎨 Aesthetic Philosophy

- **Palette**: Pure Black (`#000000`), Neon Red (`#ff0033`), Cyber Yellow (`#ffcc00`), Cyan (`#00ffff`).
- **Style**: "HUD" Wireframe. No blur. No shadows. Sharp pixels.
- **Typography**: JetBrains Mono Nerd Font.
- **Workspaces**: Kanji Numerals (`一`, `二`, `三`, `四`).

## 🏯 Component Architecture

| Component | Choice | Customization |
| :--- | :--- | :--- |
| **Window Manager** | Hyprland | No blur/shadows, 2px neon gradients. `Alt` mod key. |
| **Bar** | Waybar | Custom "Wireframe" CSS. Transparent background. |
| **Terminal** | Foot | "Neon Shogun" scheme. Deprecated settings fixed. |
| **Shell** | Fish | Custom `up2date` command. |
| **Launcher** | Rofi | Minimal text list. "Samurai Prompt" style. |
| **File Manager** | Dolphin | Custom Kage Qt5 theme. |
| **Browser** | Firefox | `userChrome.css` injection for pitch black UI. |
| **Display Manager** | SDDM | Sugar-Dark (Modified). |

## 🛠️ Modifications from Original

This fork completely overhauls the original Dionysus base:
- **Stripped**: Eww widgets, Cava, Zsh, Neofetch, Blur effects.
- **Added**: Fastfetch (Custom art), Foot, Fish, Automated Installer, `up2date` auto-updater.
- **Refined**: Redesigned Waybar modules for performance.

## ⚖️ Credits

- **Original Base**: [Dionysus](https://github.com/pewdiepie-archdaemon/dionysus)
- **Theme Design**: Kage (Shadow) Implementation
