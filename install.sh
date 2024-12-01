#!/bin/bash

# Define colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Dotfiles directory
DOTFILES="$HOME/Documents/mydotfiles"
BACKUP_DIR="$HOME/.config/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

# Create backup directory
mkdir -p "$BACKUP_DIR"
echo -e "${BLUE}Created backup directory at $BACKUP_DIR${NC}"

# Function to safely remove directory or symlink
safe_remove() {
    local target=$1
    if [ -e "$target" ] || [ -L "$target" ]; then
        echo -e "${BLUE}Removing $target${NC}"
        rm -rf "$target"
    fi
}

# Function to create symlink
create_symlink() {
    local target=$1
    local source=$2
    
    echo -e "\n${BLUE}Processing: $target${NC}"
    
    # Backup and remove existing directory/symlink
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo -e "${BLUE}Backing up existing file/directory: $target${NC}"
        cp -R "$target" "$BACKUP_DIR/"
    fi
    
    # Remove existing directory or symlink
    safe_remove "$target"
    
    # Create symbolic link
    echo -e "${GREEN}Creating symlink: $target -> $source${NC}"
    ln -sfn "$source" "$target"
    
    # Verify the symlink
    if [ -L "$target" ]; then
        echo -e "${GREEN}✓ Successfully created symlink for $(basename "$target")${NC}"
    else
        echo -e "${RED}✗ Failed to create symlink for $(basename "$target")${NC}"
    fi
}

# Create symlinks for each config
create_symlink "$HOME/.config/karabiner" "$DOTFILES/karabiner"
create_symlink "$HOME/.config/kitty" "$DOTFILES/kitty"
create_symlink "$HOME/.config/nvim" "$DOTFILES/nvim"
create_symlink "$HOME/.config/sketchybar" "$DOTFILES/sketchybar"
create_symlink "$HOME/.config/yabai" "$DOTFILES/yabai"
create_symlink "$HOME/.zshrc" "$DOTFILES/.zshrc"  # Added .zshrc symlink

# Print results
echo -e "\n${GREEN}Setup complete!${NC}"
echo -e "${BLUE}Backup of old configurations can be found in: $BACKUP_DIR${NC}"

# Verify all symlinks
echo -e "\n${BLUE}Verifying symlinks:${NC}"
for config in karabiner kitty nvim sketchybar yabai; do
    target="$HOME/.config/$config"
    if [ -L "$target" ]; then
        echo -e "${GREEN}✓ $config is properly linked${NC}"
    else
        echo -e "${RED}✗ $config is not linked${NC}"
    fi
done

# Verify .zshrc symlink separately
if [ -L "$HOME/.zshrc" ]; then
    echo -e "${GREEN}✓ .zshrc is properly linked${NC}"
else
    echo -e "${RED}✗ .zshrc is not linked${NC}"
fi
