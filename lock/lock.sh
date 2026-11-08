#!/bin/bash

set -e

# Directorio de copia de seguridad (lo exporta install.sh)
BACKUP_DIR="${BACKUP_DIR:-$(cd "$(dirname "$0")/.." && pwd)/copiaseguridad/manual}"
mkdir -p "$BACKUP_DIR"

# Copio la configuracion de hyprlock y hypridle a .config/hypr
mkdir -p ~/.config/hypr

# Copia seguridad
mkdir -p "$BACKUP_DIR/hypr"
if [[ -f "$HOME/.config/hypr/hypridle.conf" ]]; then
  mv ~/.config/hypr/hypridle.conf "$BACKUP_DIR/hypr/"
fi

if [[ -f "$HOME/.config/hypr/hyprlock.conf" ]]; then
  mv ~/.config/hypr/hyprlock.conf "$BACKUP_DIR/hypr/"
fi

cp hyprlock.conf ~/.config/hypr/hyprlock.conf
cp hypridle.conf ~/.config/hypr/hypridle.conf
