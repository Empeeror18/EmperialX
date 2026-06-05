# Installation Guide

This guide walks you through installing and configuring EmperialX on Arch Linux. Follow each step carefully to ensure a smooth setup.

---

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Pre-Installation Checklist](#pre-installation-checklist)
3. [Installing the AUR Helper](#installing-the-aur-helper)
4. [Cloning the Repository](#cloning-the-repository)
5. [Installing Dependencies](#installing-dependencies)
6. [Backing Up Existing Configs](#backing-up-existing-configs)
7. [Copying Dotfiles](#copying-dotfiles)
8. [Setting Up pywal](#setting-up-pywal)
9. [Launching Hyprland](#launching-hyprland)
10. [Post-Installation Setup](#post-installation-setup)
11. [Troubleshooting Installation](#troubleshooting-installation)

---

## Prerequisites

Before starting, ensure your system meets these requirements:

- **OS**: Arch Linux (fresh or existing installation)
- **Git**: Installed and configured (`sudo pacman -S git`)
- **AUR Helper**: `yay` or `paru` for easy package installation
- **Basic Terminal Knowledge**: Comfort with shell commands and file navigation

---

## Pre-Installation Checklist

Before proceeding, verify:

```bash
# Check if git is installed
git --version

# Check if yay/paru is installed (if not, see next section)
yay --version  # or: paru --version

# Verify you're on Arch Linux
cat /etc/os-release

# Check GPU drivers are installed
lspci | grep -E "VGA|3D"
```

---

## Installing the AUR Helper

If you don't have `yay` or `paru` installed, install `yay` now:

```bash
# Install git and base-devel (required to build from AUR)
sudo pacman -S --needed git base-devel

# Clone the yay repository
git clone https://aur.archlinux.org/yay.git
cd yay

# Build and install yay
makepkg -si

# Verify installation
yay --version

# Clean up
cd ..
rm -rf yay
```

If you prefer `paru` instead:

```bash
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rm -rf paru
```

---

## Cloning the Repository

Clone the EmperialX dotfiles:

```bash
# Clone from the waybar branch
git clone --branch waybar https://github.com/Empeeror18/EmperialX
cd EmperialX

# Verify you're on the correct branch
git branch -v
```

The `waybar` branch contains the most recent, polished configuration. If you want to explore other branches:

```bash
git branch -a      # List all branches
git checkout <branch-name>  # Switch to a different branch
```

---

## Installing Dependencies

This repository requires several packages across different categories. Install them in order:

### Core Compositor & Bar

```bash
yay -S hyprland waybar wofi kitty
```

- **hyprland**: Wayland compositor (the window manager)
- **waybar**: Status bar with modular widgets
- **wofi**: Application launcher
- **kitty**: GPU-accelerated terminal emulator

### Hyprland Ecosystem

```bash
yay -S hyprlock hyprpaper hypridle xdg-desktop-portal-hyprland
```

- **hyprlock**: Lockscreen with biometric support
- **hyprpaper**: Wallpaper daemon for Wayland
- **hypridle**: Idle management (for auto-locking)
- **xdg-desktop-portal-hyprland**: XDG desktop portal for Hyprland

### Wallpaper & Color Management

```bash
yay -S awww python-pywal imagemagick
```

- **pywal**: Color extraction and dynamic theming engine
- **imagemagick**: Image manipulation (dependency for pywal)
- **awww**: Alternative wallpaper setter (optional but recommended)

### Notifications & Audio

```bash
yay -S swaync cava pipewire pipewire-pulse wireplumber
```

- **swaync**: Notification daemon for Wayland
- **cava**: Audio visualizer
- **pipewire** + **wireplumber**: Modern audio server stack

### Utilities

```bash
yay -S thunar wlogout brightnessctl playerctl pactl grim slurp flameshot wl-clipboard
```

- **thunar**: File manager
- **wlogout**: Session / logout menu
- **brightnessctl**: Brightness control
- **playerctl**: Media player control
- **pactl**: PulseAudio control (audio settings)
- **grim** + **slurp**: Screenshot tools
- **flameshot**: Interactive screenshot tool
- **wl-clipboard**: Wayland clipboard support

### Development Tools

```bash
yay -S neovim ripgrep fd stylua
```

- **neovim**: Modal text editor with LSP support
- **ripgrep**: Fast file content search
- **fd**: Fast file finder
- **stylua**: Lua code formatter

### Fonts

```bash
yay -S ttf-jetbrains-mono-nerd ttf-meslo-nerd-font-powerlevel10k noto-fonts noto-fonts-emoji
```

- **ttf-jetbrains-mono-nerd**: Primary monospace font with Nerd Font icons
- **ttf-meslo-nerd-font-powerlevel10k**: Alternative Nerd Font
- **noto-fonts**: Wide character support
- **noto-fonts-emoji**: Emoji support

### Desktop Theme

```bash
yay -S graphite-gtk-theme capitaine-cursors
```

- **graphite-gtk-theme**: GTK application theming
- **capitaine-cursors**: Cursor theme

### Optional Extras

```bash
yay -S udiskie thunar-volman
```

- **udiskie**: USB automounting daemon
- **thunar-volman**: Volume management for Thunar

### All-in-One Installation

If you prefer to install everything at once:

```bash
yay -S hyprland waybar wofi kitty hyprlock hyprpaper hypridle xdg-desktop-portal-hyprland \
  awww python-pywal imagemagick swaync cava pipewire pipewire-pulse wireplumber \
  thunar wlogout brightnessctl playerctl pactl grim slurp flameshot wl-clipboard \
  neovim ripgrep fd stylua ttf-jetbrains-mono-nerd ttf-meslo-nerd-font-powerlevel10k \
  noto-fonts noto-fonts-emoji graphite-gtk-theme capitaine-cursors udiskie thunar-volman
```

---

## Backing Up Existing Configs

**Before copying new dotfiles, always back up your current configuration:**

```bash
# Create a backup directory
mkdir -p ~/.dotfiles-backup

# Back up your entire .config directory
cp -r ~/.config ~/.dotfiles-backup/

# Also back up other important files if they exist
cp ~/.bashrc ~/.dotfiles-backup/ 2>/dev/null || true
cp ~/.zshrc ~/.dotfiles-backup/ 2>/dev/null || true

echo "Backup saved to ~/.dotfiles-backup"
```

This ensures you can restore your previous setup if something goes wrong.

---

## Copying Dotfiles

### Option 1: Copy Everything (Recommended for Fresh Installs)

```bash
# Copy all .config files
cp -r .config/* ~/.config/

# Create wallpaper directory and copy wallpapers
mkdir -p ~/wall
cp -r wallpapers/* ~/wall/ 2>/dev/null || true

echo "Dotfiles copied successfully"
```

### Option 2: Copy Components Individually (Recommended for Existing Users)

Copy only the components you want to integrate:

```bash
# Copy core components
cp -r .config/hypr       ~/.config/
cp -r .config/waybar     ~/.config/
cp -r .config/kitty      ~/.config/
cp -r .config/wofi       ~/.config/

# Copy editor
cp -r .config/nvim       ~/.config/

# Copy visualizers and menus
cp -r .config/cava       ~/.config/
cp -r .config/rofi       ~/.config/

# Copy font and other configs
cp -r .config/fontconfig ~/.config/
```

### Option 3: Manual Selection

Navigate to the `EmperialX` directory and manually select files:

```bash
cd EmperialX
ls -la .config/

# Copy individual directories as needed
cp -r .config/hypr ~/.config/
```

---

## Setting Up pywal

The pywal color pipeline is essential for the dynamic theming system. Set it up now:

### Initialize with a Wallpaper

```bash
# Use a wallpaper from the included collection
wal -i ~/wall/bg_16.png

# Or use any wallpaper on your system
wal -i ~/Pictures/your-wallpaper.jpg

# Or to let pywal find a random image
wal -r
```

After running this command:

- Colors are extracted from the wallpaper
- Color files are generated in `~/.cache/wal/`
- Waybar, Kitty, Wofi, and other components will automatically update

### Verify pywal Setup

```bash
# Check if color cache exists
ls -la ~/.cache/wal/

# View the generated colors
cat ~/.cache/wal/colors
```

---

## Launching Hyprland

### From a Display Manager (SDDM)

1. Log out of your current session
2. On the login screen, select **Hyprland** from the session menu (usually a dropdown or settings icon)
3. Enter your credentials and login

### From the Terminal

If you're in a TTY or another desktop environment:

```bash
# Start Hyprland directly
Hyprland

# Or with verbose logging
Hyprland -v
```

**First Launch Notes:**

- Hyprland will start with the keybindings from your config
- Press `Super` (Windows key) to access the application menu
- If the screen is black, press `Super + Return` to open a terminal
- Check the Hyprland logs if something doesn't work: `cat ~/.cache/hyprland/hyprland.log`

---

## Post-Installation Setup

### Fix Hardcoded Username Paths

Some config files contain hardcoded paths like `/home/emperor/`. If your username is different, update them:

```bash
# Find all occurrences of "emperor" in config files
grep -r "emperor" ~/.config/ --include="*.css" --include="*.conf" --include="*.jsonc"

# Replace all occurrences (change YOUR_USERNAME to your actual username)
find ~/.config -type f \( -name "*.css" -o -name "*.conf" -o -name "*.jsonc" \) \
  -exec sed -i 's|/home/emperor|/home/YOUR_USERNAME|g' {} \;
```

Verify the replacements:

```bash
# Should return no results
grep -r "emperor" ~/.config/ --include="*.css" --include="*.conf" --include="*.jsonc"
```

### Apply GTK Theme

```bash
# Set GTK theme
gsettings set org.gnome.desktop.interface gtk-theme 'Graphite'

# Set cursor theme
gsettings set org.gnome.desktop.interface cursor-theme 'capitaine-cursors'

# Or use nwg-look for a GUI:
yay -S nwg-look
nwg-look
```

### Rebuild Font Cache

```bash
fc-cache -fv
```

### Test Individual Components

**Waybar:**

```bash
waybar -c ~/.config/waybar/config.jsonc -l debug
```

**Kitty:**

```bash
kitty --version
# Verify fonts are loaded
fc-list | grep -i jetbrains
```

**Neovim:**

```bash
nvim +Lazy
# Press 'q' to exit, plugins will auto-install on next launch
```

**pywal:**

```bash
# Test color generation
wal -i ~/wall/bg_16.png
echo "Colors saved to ~/.cache/wal/"
```

---

## Troubleshooting Installation

### Hyprland Won't Start

**Error**: "Failed to acquire session" or black screen

**Solutions**:

1. **Check GPU drivers**:

   ```bash
   # For NVIDIA
   glxinfo | grep -i nvidia

   # For AMD
   glxinfo | grep -i radeon

   # For Intel
   glxinfo | grep -i intel
   ```

2. **Check Hyprland logs**:

   ```bash
   cat ~/.cache/hyprland/hyprland.log
   tail -f ~/.cache/hyprland/hyprland.log  # Follow logs in real-time
   ```

3. **Ensure xdg-desktop-portal is installed**:

   ```bash
   yay -S xdg-desktop-portal-hyprland
   ```

4. **Check for conflicting packages**:
   ```bash
   yay -Syu  # Update all packages
   ```

### pywal Colors Not Applying

**Error**: Waybar still shows default colors after running `wal`

**Solutions**:

1. **Reload components**:

   ```bash
   # Restart Waybar
   pkill waybar && sleep 1 && ~/.config/waybar/scripts/launch.sh

   # Restart Kitty (or any open Kitty windows)
   pkill kitty
   ```

2. **Verify cache files exist**:

   ```bash
   ls -la ~/.cache/wal/
   cat ~/.cache/wal/colors-waybar.css
   ```

3. **Regenerate colors**:
   ```bash
   wal -R  # Restore last palette
   # or
   wal -i ~/wall/bg_16.png  # Regenerate from wallpaper
   ```

### Waybar Not Showing

**Error**: Waybar doesn't appear on screen

**Solutions**:

1. **Check config syntax**:

   ```bash
   waybar -c ~/.config/waybar/config.jsonc -l debug
   ```

2. **Verify JSON is valid**:

   ```bash
   cat ~/.config/waybar/config.jsonc | python3 -m json.tool
   ```

3. **Check module files**:

   ```bash
   ls -la ~/.config/waybar/modules/
   ```

4. **Manually restart Waybar**:
   ```bash
   pkill waybar
   ~/.config/waybar/scripts/launch.sh
   ```

### Missing Icons in Waybar

**Error**: Waybar shows squares instead of icons

**Solutions**:

1. **Verify Nerd Fonts are installed**:

   ```bash
   fc-list | grep -i nerd
   fc-list | grep -i jetbrains
   ```

2. **Rebuild font cache**:

   ```bash
   fc-cache -fv
   ```

3. **Manually install Nerd Fonts**:
   ```bash
   yay -S ttf-jetbrains-mono-nerd ttf-meslo-nerd-font-powerlevel10k
   fc-cache -fv
   ```

### Kitty Terminal Issues

**Error**: Wrong font or character display issues

**Solutions**:

1. **Verify MesloLGS is installed**:

   ```bash
   fc-list | grep -i meslo
   ```

2. **Install missing font**:

   ```bash
   yay -S ttf-meslo-nerd-font-powerlevel10k
   fc-cache -fv
   ```

3. **Reset Kitty config**:

   ```bash
   # Backup current config
   cp ~/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf.bak

   # Copy fresh config from dotfiles
   cp EmperialX/.config/kitty/kitty.conf ~/.config/kitty/
   ```

### Neovim LSP Not Working

**Error**: `:LspInfo` shows no servers attached

**Solutions**:

1. **Check which language servers are needed**:

   ```bash
   nvim ~/.config/nvim/lua/plugins/lsp.lua  # Review configured servers
   ```

2. **Install language servers** (examples):

   ```bash
   yay -S lua-language-server
   yay -S typescript-language-server
   yay -S pyright
   yay -S bash-language-server
   ```

3. **Reload Neovim**:
   ```bash
   nvim +LspStart  # Manual start if needed
   ```

### Permission Denied Errors

**Error**: `Permission denied` when copying files

**Solutions**:

```bash
# Ensure you own ~/.config
sudo chown -R $USER:$USER ~/.config

# Or copy with proper permissions
cp -r .config/* ~/.config/
chmod 755 ~/.config
```

### Broken Symlinks After Migration

**Error**: Some config references broken symlinks

**Solutions**:

```bash
# Find broken symlinks
find ~/.config -type l ! -exec test -e {} \; -print

# Remove them if not needed
find ~/.config -type l ! -exec test -e {} \; -delete
```

---

## Verification Checklist

After installation, verify everything is working:

- [ ] Hyprland launches without errors
- [ ] Waybar displays and shows the correct time
- [ ] `Super + D` opens the Wofi launcher
- [ ] `Super + Return` opens Kitty terminal
- [ ] Colors change when you run `wal -i ~/wall/bg_16.png`
- [ ] Screenshots work with `Super + Print`
- [ ] Volume and brightness controls work
- [ ] Neovim opens and plugins load

---


**Happy ricing! 🎨**
