#!/bin/bash

DOTFILES_DIR=~/dotfiles
CONFIG_DIR=~/.config
BIN_DIR=~/.local/bin

declare -A DOTFILES
DOTFILES=(
    ["hypr"]="$CONFIG_DIR/hypr"
    ["waybar"]="$CONFIG_DIR/waybar"
    ["rofi"]="$CONFIG_DIR/rofi"
    ["kitty"]="$CONFIG_DIR/kitty"
    ["matugen"]="$CONFIG_DIR/matugen"
    ["ohmyposh"]="$CONFIG_DIR/ohmyposh"
)

declare -A HOME_FILES
HOME_FILES=(
    [".zshrc"]="$HOME/.zshrc"
)

declare -A SCRIPTS
SCRIPTS=(
    ["wallpaperset"]="$BIN_DIR/wallpaperset"
)

echo "Setting up dotfiles..."

for folder in "${!DOTFILES[@]}"; do
    TARGET="${DOTFILES[$folder]}"
    SOURCE="$DOTFILES_DIR/$folder"

    rm -rf "$TARGET"
    ln -sfn "$SOURCE" "$TARGET"
    echo "Linked $SOURCE -> $TARGET"
done

for file in "${!HOME_FILES[@]}"; do
    SOURCE="$DOTFILES_DIR/$file"
    TARGET="${HOME_FILES[$file]}"

    rm -f "$TARGET"
    ln -sfn "$SOURCE" "$TARGET"
    echo "Linked $SOURCE -> $TARGET"
done

mkdir -p "$BIN_DIR"
for script in "${!SCRIPTS[@]}"; do
    TARGET="${SCRIPTS[$script]}"
    SOURCE="$DOTFILES_DIR/scripts/$script"

    rm -f "$TARGET"
    ln -sfn "$SOURCE" "$TARGET"
    chmod +x "$SOURCE"
    echo "Linked script $SOURCE -> $TARGET"
done

if command -v hyprctl >/dev/null 2>&1; then
    hyprctl reload
fi

echo "Dotfiles setup complete!"
