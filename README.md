


<p align="center">
  🇪🇸 Español | <a href="README.en.md">🇬🇧 English</a>
</p>

# MinimalHypr

Entorno de escritorio minimalista basado en Hyprland. Un único script instala las dependencias y despliega la configuración de la terminal, el lanzador, los fondos de pantalla, la barra, las notificaciones, el bloqueo de pantalla y el gestor de inicio de sesión.

[Preview.webm](https://github.com/user-attachments/assets/6fbc5176-05c9-440c-9b84-bffa6e46def9)

## Qué incluye

| Módulo           | Herramienta         | Descripción                                                                                              |
| ---------------- | ------------------- | -------------------------------------------------------------------------------------------------------- |
| `terminal/`      | kitty + zsh + nvim  | zsh con oh-my-zsh, powerlevel10k, autosuggestions, syntax-highlighting, alias de `eza`, atajos de `fzf` y Neovim con LazyVim |
| `launcher/`      | rofi                | Lanzador de aplicaciones (`applauncher.rasi`)                                                            |
| `wallpapers/`    | awww                | Fondos normales y animados (GIF) con script para ciclar entre ellos                                      |
| `waybar/`        | waybar              | Barra superior: workspaces, reloj, caffeine, audio, micrófono, batería, bandeja y botón de apagado       |
| `notifications/` | mako                | Notificaciones                                                                                           |
| `lock/`          | hyprlock + hypridle | Bloqueo a los 5 min de inactividad y pantalla apagada a los 5 min 30 s                                   |
| `greeter/`       | greetd + tuigreet   | Pantalla de login en terminal                                                                            |
| `include/`       | Lua                 | Atajos, demonios y ajustes que se añaden a `hyprland.lua`                                                |

## Requisitos

- Distribucion rolin release con `pacman`.
- Hyprland ya instalado y **haber arrancado al menos una vez con `start-hyprland`**, para que exista `~/.config/hypr/hyprland.lua`. El instalador aborta si no lo encuentra.
- Usuario con permisos de `sudo` y conexión a internet.

## Instalación

```bash
git clone <url-del-repositorio> MinimalHypr
cd MinimalHypr
chmod +x install.sh
./install.sh
```

El script:

1. Actualiza el sistema (`pacman -Syu`) e instala `paru` si no está.
2. Instala las dependencias con `pacman` y `paru` (incluye `kitty`, `rofi`, `waybar`, `mako`, `hyprlock`, `hypridle`, `greetd`, `neovim`, `yazi`, `zsh`, fuentes JetBrains Mono Nerd, y aplicaciones como `zen-browser`, `obsidian`, `bitwarden`, `btop`…).
3. Ejecuta el script de cada módulo en orden y muestra un resumen con ✔/✘.
4. Copia `include/*.lua` a `~/.config/hypr/` y añade los `require(...)` correspondientes a `hyprland.lua` (solo si no estaban ya).
5. Ofrece reiniciar al terminar.

> **Aviso:** el instalador cambia tu shell por defecto a zsh, activa `greetd` como gestor de login y reemplaza configuraciones existentes. Léelo antes de ejecutarlo.

### Copias de seguridad

Antes de sobrescribir, cada módulo mueve tu configuración anterior a `copiaseguridad/<fecha-hora>/` dentro del repositorio (carpeta ignorada por git). Para restaurar algo, copia de vuelta desde ahí.

## Atajos de teclado

| Atajo               | Acción                                                                             |
| ------------------- | ---------------------------------------------------------------------------------- |
| `SUPER + Enter`     | Terminal (kitty)                                                                   |
| `SUPER + Space`     | Lanzador de aplicaciones (rofi)                                                    |
| `SUPER + E`         | Gestor de archivos (yazi)                                                          |
| `SUPER + N`         | Neovim (LazyVim)                                                                           |
| `SUPER + B`         | Navegador (zen-browser)                                                            |
| `SUPER + Q`         | Cerrar ventana                                                                     |
| `SUPER + F`         | Maximizar / restaurar                                                              |
| `SUPER + V`         | Alternar ventana flotante                                                          |
| `SUPER + P`         | Captura de una región (guarda en `~/Pictures/Screenshots` y copia al portapapeles) |
| `SUPER + Shift + L` | Bloquear pantalla                                                                  |
| `SUPER + W`         | Siguiente fondo animado                                                            |
| `SUPER + L`         | Siguiente fondo normal                                                             |

Los atajos viven en `include/keybinds.lua`.

## Personalización

- **Atajos:** `include/keybinds.lua`
- **Gaps, opacidad, touchpad:** `include/settings.lua`
- **Programas que arrancan con la sesión:** `include/daemons.lua`
- **Tiempos de bloqueo:** `lock/hypridle.conf`
- **Colores del login:** `greeter/config.toml`
- **Fondos:** añade imágenes a `wallpapers/NormalWallpapers/` o GIFs a `wallpapers/LiveWallpapers/` antes de instalar (o directamente en `~/.config/awww/` después).

Si modificas algo del repositorio, vuelve a ejecutar el script del módulo (por ejemplo `cd waybar && ./waybar.sh`) o el instalador completo para desplegarlo.

## Estructura

```
MinimalHypr/
├── install.sh
├── include/        # keybinds.lua, daemons.lua, settings.lua
├── terminal/       # kitty.conf, terminal.sh
├── launcher/       # applauncher.rasi, launcher.sh
├── wallpapers/     # fondos, switcher.sh, wallpapers.sh
├── waybar/         # config.jsonc, style.css, waybar.sh
├── notifications/  # config (mako), notifications.sh
├── lock/           # hyprlock.conf, hypridle.conf, lock.sh
└── greeter/        # config.toml (greetd), greeter.sh
```

## Créditos

- Fondos de pantalla: [D3Ext/aesthetic-wallpapers](https://github.com/D3Ext/aesthetic-wallpapers)
- Tema del lanzador rofi (base): [adi1090x/rofi](https://github.com/adi1090x/rofi)
- Configuración de Neovim: [LazyVim/starter](https://github.com/LazyVim/starter)
