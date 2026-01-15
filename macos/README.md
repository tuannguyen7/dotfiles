# macOS Setup Guide

## 🚀 Quick Start (New Mac Setup)

On a brand new Mac, run these commands:

```bash
# 1. Clone this repository
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles/macos

# 2. Run the bootstrap script (installs everything)
./bootstrap.sh
```

That's it! The bootstrap script will:
- ✅ Install Homebrew (if needed)
- ✅ Install all packages from Brewfile
- ✅ Install Oh My Zsh
- ✅ Symlink all dotfiles using GNU Stow
- ✅ Backup any existing config files

## 📦 What Gets Installed

The `Brewfile` includes:

### Core CLI Tools
- **neovim** - Modern text editor
- **tmux** - Terminal multiplexer
- **stow** - Dotfiles symlink manager
- **fzf** - Fuzzy finder
- **ripgrep** - Fast grep tool (required by Neovim Telescope)

### Kubernetes Tools
- **kubectl** - Kubernetes CLI
- **kubectx** - Context switcher (includes kubens)

### GUI Applications
- **Alacritty** - GPU-accelerated terminal
- **Docker Desktop** - Container platform

### Fonts
- **RobotoMono Nerd Font** - Patched font with icons

## 🔧 Manual Setup (Step by Step)

If you prefer to install manually:

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install packages from Brewfile
brew bundle install

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Symlink dotfiles
mkdir -p ~/.config
stow --dotfiles -t ~/.config dot-config
stow --dotfiles -t ~ zshrc
stow --dotfiles -t ~ tmux
```

## 🔄 Updating Dependencies

To keep your packages up to date:

```bash
# Update Homebrew and all packages
brew update && brew upgrade

# Save current packages to Brewfile
brew bundle dump --force --file=Brewfile
```

## 📚 Additional Resources

- [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) - Icon fonts for terminal
- [GNU Stow](https://www.gnu.org/software/stow/) - Symlink manager
- [Homebrew Bundle](https://github.com/Homebrew/homebrew-bundle) - Package manager
