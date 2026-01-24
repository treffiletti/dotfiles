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

# Source .zshrc if in zsh
if [ -n "$ZSH_VERSION" ]; then
    echo "Sourcing .zshrc"
    source "$HOME/.zshrc"
fi

echo ""
echo "Installation complete!"
echo "Your old dotfiles have been backed up to $BACKUP_DIR"
echo ""
echo "IMPORTANT: Create a .env.local file in $DOTFILES_DIR with your secrets!"
echo "See .env.local.example for template"
