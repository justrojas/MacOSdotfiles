#!/bin/bash

# Define colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Dotfiles directory
DOTFILES="$HOME/Documents/mydotfiles"

# Array of files/folders to symlink
declare -A files=(
    ["$HOME/.config/karabiner"]="$DOTFILES/karabiner"
    ["$HOME/.config/kitty"]="$DOTFILES/kitty"
    ["$HOME/.config/nvim"]="$DOTFILES/nvim"
    ["$HOME/.config/sketchybar"]="$DOTFILES/sketchybar"
    ["$HOME/.config/yabai"]="$DOTFILES/yabai"
)

# Function to backup existing files
backup_file() {
    local file=$1
    if [ -e "$file" ]; then
        echo -e "${BLUE}Backing up existing $file${NC}"
        mv "$file" "$file.backup.$(date +%Y%m%d_%H%M%S)"
    fi
}

# Create necessary directories
echo -e "${BLUE}Creating required directories...${NC}"
mkdir -p "$HOME/.config"

# Create symlinks
for target in "${!files[@]}"; do
    source="${files[$target]}"
    
    # Backup existing files/symlinks
    backup_file "$target"
    
    # Create symbolic link
    echo -e "${GREEN}Creating symlink: $target -> $source${NC}"
    ln -sf "$source" "$target"
done

echo -e "${GREEN}Setup complete! Your dotfiles are now symlinked.${NC}"
