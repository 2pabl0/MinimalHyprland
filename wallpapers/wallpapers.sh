#!/bin/bash

set -e

# Directorio de copia de seguridad (lo exporta install.sh)
BACKUP_DIR="${BACKUP_DIR:-$(cd "$(dirname "$0")/.." && pwd)/copiaseguridad/manual}"
mkdir -p "$BACKUP_DIR"

# Copio la carpeta de fondos de pantalla ---> creditos: https://github.com/D3Ext/aesthetic-wallpapers.git

if [[ -e "$HOME/.config/awww" ]]; then
  mv ~/.config/awww/ "$BACKUP_DIR/awww"
fi
mkdir -p ~/.config/awww
cp -r LiveWallpapers ~/.config/awww
cp -r NormalWallpapers ~/.config/awww
cp switcher.sh ~/.config/awww
chmod +x ~/.config/awww/switcher.sh
