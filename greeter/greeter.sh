#!/bin/bash
set -e

# Directorio de copia de seguridad (lo exporta install.sh)
BACKUP_DIR="${BACKUP_DIR:-$(cd "$(dirname "$0")/.." && pwd)/copiaseguridad/manual}"
mkdir -p "$BACKUP_DIR"

# Activo greetd
sudo systemctl enable -f greetd.service

# Copia seguridad
if [[ -f "/etc/greetd/config.toml" ]]; then
  mkdir -p "$BACKUP_DIR/greeter"
  sudo cp /etc/greetd/config.toml "$BACKUP_DIR/greeter/"
  sudo chown "$USER" "$BACKUP_DIR/greeter/config.toml"
fi
# Copio el contenido de config.toml a su correspondiente ruta
sudo install -m 644 ./config.toml /etc/greetd/config.toml
