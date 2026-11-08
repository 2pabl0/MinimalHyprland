#!/bin/bash

set -e

# Directorio de copia de seguridad (lo exporta install.sh)
BACKUP_DIR="${BACKUP_DIR:-$(cd "$(dirname "$0")/.." && pwd)/copiaseguridad/manual}"
mkdir -p "$BACKUP_DIR"

# Activo los servicios
sudo systemctl enable --now NetworkManager
systemctl --user enable --now pipewire.socket pipewire-pulse.socket wireplumber
sudo systemctl enable --now bluetooth

# Copio los archivos de configuracion a .config/waybar
if [[ -e "$HOME/.config/waybar/" ]]; then
  mv ~/.config/waybar/ "$BACKUP_DIR/waybar"
fi
mkdir -p ~/.config/waybar
cp config.jsonc style.css ~/.config/waybar/
