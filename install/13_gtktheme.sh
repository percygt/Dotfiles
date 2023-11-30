#!/bin/bash
set -eu

[ "$UID" -ne 0 ] || { echo "This script must be run by $SUDO_USER."; exit 1;}

CONFIG_DIR="$HOME/.config"
THEMES_DIR="$HOME/.local/share/themes"
ICONS_DIR="$HOME/.local/share/icons"

USR_ICONS_DIR="/usr/share/icons"
USR_THEMES_DIR="/usr/share/themes"

THEME="Colloid-Dark-Nord"
SHELL_THEME="Marble-crispblue-dark"


rm -rf "$HOME/.themes"
ln -s "$THEMES_DIR" "$HOME/.themes"

[ -d "$CONFIG_DIR/gtk-4.0" ] && rm -rf "$CONFIG_DIR/gtk-4.0"
mkdir "$CONFIG_DIR/gtk-4.0"
ln -s "$THEMES_DIR/$THEME/gtk-4.0/gtk.css" "$CONFIG_DIR/gtk-4.0/gtk.css"
ln -s "$THEMES_DIR/$THEME/gtk-4.0/gtk-dark.css" "$CONFIG_DIR/gtk-4.0/gtk-dark.css"
ln -s "$THEMES_DIR/$THEME/gtk-4.0/assets" "$CONFIG_DIR/gtk-4.0/assets"

echo "copy shell theme to /usr/share/themes"
sudo cp -rv "$ICONS_DIR/." "$USR_ICONS_DIR/"

echo "copy shell theme to /usr/share/themes"
sudo cp -rv "$THEMES_DIR/$SHELL_THEME" "$USR_THEMES_DIR/"



