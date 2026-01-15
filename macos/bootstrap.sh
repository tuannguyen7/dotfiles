#!/usr/bin/env bash

# Bootstrap script for setting up a new macOS machine
# This script should be run after cloning this dotfiles repository

set -e  # Exit on error

echo "🚀 Starting macOS bootstrap process..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}==>${NC} $1"
}

print_error() {
    echo -e "${RED}Error:${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}Warning:${NC} $1"
}

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    print_status "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == 'arm64' ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    print_status "Homebrew already installed. Updating..."
    brew update
fi

# Install all packages from Brewfile
print_status "Installing packages from Brewfile..."
cd "$(dirname "$0")"
brew bundle install

# Install Oh My Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    print_status "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    print_status "Oh My Zsh already installed. Skipping..."
fi

# Create .config directory if it doesn't exist
print_status "Creating ~/.config directory..."
mkdir -p ~/.config

# Backup existing dotfiles
print_status "Backing up existing dotfiles (if any)..."
backup_dir="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$backup_dir"

for item in ~/.zshrc ~/.tmux.conf ~/.config/nvim ~/.config/alacritty ~/.ideavimrc; do
    if [ -e "$item" ] && [ ! -L "$item" ]; then
        print_warning "Backing up existing $(basename $item) to $backup_dir"
        mv "$item" "$backup_dir/"
    fi
done

# Stow dotfiles
print_status "Stowing dotfiles..."
stow --dotfiles -t ~/.config dot-config -v
stow --dotfiles -t ~ zshrc -v
stow --dotfiles -t ~ tmux -v

# Install fzf key bindings and fuzzy completion
if command -v fzf &> /dev/null; then
    print_status "Installing fzf key bindings and fuzzy completion..."
    $(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc
fi

# Set up Neovim (install plugins on first launch)
print_status "Neovim will install plugins on first launch..."

print_status "✅ Bootstrap complete!"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Open Neovim to install plugins: nvim"
echo "  3. (Optional) Configure git: git config --global user.name 'Your Name'"
echo "  4. (Optional) Configure git: git config --global user.email 'your@email.com'"
echo ""
echo "Backup location (if any): $backup_dir"
