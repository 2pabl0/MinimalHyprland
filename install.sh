#!/bin/bash

ruta_raiz="$(cd "$(dirname "$0")" && pwd)"
ROJO='\033[0;31m'
VERDE='\033[32m'
NC='\033[0m'
estado_terminal="${ROJO}✘ terminal.sh no completado${NC}"
estado_launcher="${ROJO}✘ launcher.sh no completado${NC}"
estado_wallpapers="${ROJO}✘ wallpapers.sh no completado${NC}"
estado_waybar="${ROJO}✘ waybar.sh no completado${NC}"
estado_greeter="${ROJO}✘ greeter.sh no completado${NC}"
estado_notifications="${ROJO}✘ notifications.sh no completado${NC}"
estado_lock="${ROJO}✘ lock.sh no completado${NC}"

set -e

# Primero miro que haya lanzado start-hyprland
if [ ! -f ~/.config/hypr/hyprland.lua ]; then
  echo "Ejecuta 'start-hyprland'"
  exit 1
fi

sudo pacman -Syu --noconfirm

# Instalo paru
if ! command -v paru >/dev/null 2>&1; then
  sudo pacman -S --noconfirm --needed git base-devel
  git clone https://aur.archlinux.org/paru-bin.git &&
    cd paru-bin &&
    makepkg -si &&
    cd .. &&
    rm -rf paru-bin
fi

# Instalo las dependencias
sudo pacman -S --needed --noconfirm greetd greetd-tuigreet unzip \
  wget tar gzip nodejs npm python wl-clipboard neovim \
  git lazygit tree-sitter-cli curl fzf ripgrep fd kitty \
  ttf-jetbrains-mono-nerd grim slurp yazi ffmpeg \
  7zip jq poppler zoxide imagemagick waybar networkmanager \
  network-manager-applet rofi zsh eza pavucontrol \
  pipewire pipewire-pulse wireplumber bluez bluez-utils blueman mako libnotify hyprlock hypridle &&
  paru -S --needed --noconfirm claude-desktop bitwarden crunchyroll \
    zen-browser obsidian btop awww wlogout \
    hyprpolkitagent xdg-desktop-portal-hyprland && fc-cache -fv

# Creo el directorio de copia de seguridad
export BACKUP_DIR="$ruta_raiz/copiaseguridad/$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Configuro kitty y zsh
cd "$ruta_raiz/terminal" && chmod +x terminal.sh && ./terminal.sh &&
  cd .. && estado_terminal=$(echo -e ""${VERDE}✔ terminal.sh completado${NC}"")

# Configuro rofi para el lanzador de apps, apagado, wifi
cd "$ruta_raiz/launcher" && chmod +x launcher.sh && ./launcher.sh &&
  estado_launcher=$(echo -e ""${VERDE}✔ launcher.sh completado${NC}"")

# Configuro awww y meto los temas
cd "$ruta_raiz/wallpapers" && chmod +x wallpapers.sh && ./wallpapers.sh &&
  estado_wallpapers=$(echo -e ""${VERDE}✔ wallpapers.sh completado${NC}"")

# Configuro la waybar
cd "$ruta_raiz/waybar" && chmod +x waybar.sh && ./waybar.sh &&
  estado_waybar=$(echo -e ""${VERDE}✔ waybar.sh completado${NC}"")

# Configuro mako para las notificaciones
cd "$ruta_raiz/notifications" && chmod +x notifications.sh && ./notifications.sh &&
  estado_notifications=$(echo -e ""${VERDE}✔ notifications.sh completado${NC}"")

# Configuro hyprlock y hypridle para el bloqueo de pantalla
cd "$ruta_raiz/lock" && chmod +x lock.sh && ./lock.sh &&
  estado_lock=$(echo -e ""${VERDE}✔ lock.sh completado${NC}"")

# Configuro el greeter que va a ser tuigreet
cd "$ruta_raiz/greeter" && chmod +x greeter.sh && ./greeter.sh &&
  estado_greeter=$(echo -e ""${VERDE}✔ greeter.sh completado${NC}"")

# Muevo los requires a .config/hypr
cp "$ruta_raiz/include/settings.lua" ~/.config/hypr
cp "$ruta_raiz/include/keybinds.lua" ~/.config/hypr
cp "$ruta_raiz/include/daemons.lua" ~/.config/hypr

# Meto los requires
if (($(
  grep -qF 'require("keybinds")' ~/.config/hypr/hyprland.lua
  echo $?
) != 0)); then
  echo "---- Atajos Personalizados ----" >>~/.config/hypr/hyprland.lua
  echo "require(\"keybinds\")" >>~/.config/hypr/hyprland.lua
fi

if (($(
  grep -qF 'require("daemons")' ~/.config/hypr/hyprland.lua
  echo $?
) != 0)); then
  echo "---- Demonios Personalizados ----" >>~/.config/hypr/hyprland.lua
  echo "require(\"daemons\")" >>~/.config/hypr/hyprland.lua
fi

if (($(
  grep -qF 'require("settings")' ~/.config/hypr/hyprland.lua
  echo $?
) != 0)); then
  echo "---- Reglas Personalizadas ----" >>~/.config/hypr/hyprland.lua
  echo "require(\"settings\")" >>~/.config/hypr/hyprland.lua
fi

# Muestro la salida
echo -e "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
echo -e "Resumen instalacion:"
echo -e "    - $estado_terminal"
echo -e "    - $estado_launcher"
echo -e "    - $estado_wallpapers"
echo -e "    - $estado_waybar"
echo -e "    - $estado_notifications"
echo -e "    - $estado_lock"
echo -e "    - $estado_greeter"
echo -e "Se recomienda reiniciar:\nQuiere reiniciar ??? [y/N]"
read respuesta
if [[ "$respuesta" == "y" || "$respuesta" == "Y" ]]; then
  sudo reboot
else
  exit 0
fi
