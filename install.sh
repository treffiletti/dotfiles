#!/usr/bin/env bash
# Dotfiles installation script
# This script creates symlinks from the home directory to dotfiles in ~/dotfiles

set -e

DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

echo "Installing dotfiles from $DOTFILES_DIR"

# Create backup directory
mkdir -p "$BACKUP_DIR"
echo "Backups will be stored in $BACKUP_DIR"

# Files to symlink
files=".zshrc .zprofile .zlogin .p10k.zsh .gitconfig .gitignore_global"

# Backup and symlink files in home directory
for file in $files; do
    if [ -f "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
        echo "Backing up existing $file"
        mv "$HOME/$file" "$BACKUP_DIR/"
    fi

    if [ -L "$HOME/$file" ]; then
        echo "Removing old symlink for $file"
        rm "$HOME/$file"
    fi

    if [ -f "$DOTFILES_DIR/$file" ]; then
        echo "Creating symlink for $file"
        ln -sf "$DOTFILES_DIR/$file" "$HOME/$file"
    else
        echo "Warning: $DOTFILES_DIR/$file not found, skipping"
    fi
done

# Fish config directory
if [ -d "$DOTFILES_DIR/fish" ]; then
    mkdir -p "$HOME/.config"
    if [ -d "$HOME/.config/fish" ] && [ ! -L "$HOME/.config/fish" ]; then
        echo "Backing up existing Fish config"
        mv "$HOME/.config/fish" "$BACKUP_DIR/fish"
    fi
    if [ -L "$HOME/.config/fish" ]; then
        echo "Removing old Fish config symlink"
        rm "$HOME/.config/fish"
    fi
    echo "Creating symlink for Fish config directory"
    ln -sf "$DOTFILES_DIR/fish" "$HOME/.config/fish"
fi

# Install Fish shell
echo ""
echo "==> Setting up Fish shell..."
FISH_PATH=/opt/homebrew/bin/fish

if ! command -v fish &>/dev/null; then
    echo "Installing Fish via Homebrew..."
    brew install fish
fi

# Add Fish to /etc/shells if not already present
if ! grep -qxF "$FISH_PATH" /etc/shells; then
    echo "Adding Fish to /etc/shells (requires sudo)..."
    echo "$FISH_PATH" | sudo tee -a /etc/shells
fi

# Set Fish as default shell if not already
if [ "$SHELL" != "$FISH_PATH" ]; then
    echo "Setting Fish as default shell..."
    chsh -s "$FISH_PATH"
fi

# Install Fisher and plugins
echo "Installing Fisher plugins..."
fish -c "
    if not functions -q fisher
        curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    end
    fisher update
"

# Install Node LTS via nvm.fish if node isn't available
if ! fish -c "command -q node" &>/dev/null; then
    echo "Installing Node LTS via nvm.fish..."
    fish -c "nvm install lts"
fi

echo ""
echo "Installation complete!"
echo "Your old dotfiles have been backed up to $BACKUP_DIR"
echo ""
echo "IMPORTANT: Create a .env.local file in $DOTFILES_DIR with your secrets!"
echo "See .env.local.example for template"
echo ""
echo "Open a new terminal and run: tide configure"
