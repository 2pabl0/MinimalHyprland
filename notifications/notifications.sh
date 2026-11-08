#!/bin/bash

set -e

# Directorio de copia de seguridad (lo exporta install.sh)
BACKUP_DIR="${BACKUP_DIR:-$(cd "$(dirname "$0")/.." && pwd)/copiaseguridad/manual}"
mkdir -p "$BACKUP_DIR"

# Copio la configuracion de mako a .config/mako
mkdir -p ~/.config/mako

# Copia seguridad
if [[ -f "$HOME/.config/mako/config" ]]; then
  mkdir -p "$BACKUP_DIR/mako"
  mv ~/.config/mako/config "$BACKUP_DIR/mako/"
fi
cp config ~/.config/mako/config
