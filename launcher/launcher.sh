#!/bin/bash

set -e

# Directorio de copia de seguridad (lo exporta install.sh)
BACKUP_DIR="${BACKUP_DIR:-$(cd "$(dirname "$0")/.." && pwd)/copiaseguridad/manual}"
mkdir -p "$BACKUP_DIR"

# Voy a usar rofi para el lanzador de aplicaciones
# Copia seguridad
if [[ -e "$HOME/.config/rofi/" ]]; then
  mv ~/.config/rofi/ "$BACKUP_DIR/rofi"
fi
mkdir -p ~/.config/rofi

cp -r images ~/.config/rofi
cp applauncher.rasi ~/.config/rofi
