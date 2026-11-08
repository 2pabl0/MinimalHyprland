<p align="center">
  <a href="README.md">🇪🇸 Español</a> | 🇬🇧 English
</p>

# MinimalHypr

A minimalist desktop environment based on Hyprland. A single script installs the dependencies and deploys the configuration for the terminal, launcher, wallpapers, bar, notifications, lock screen and login manager.

## What's included

| Module           | Tool                | Description                                                                                              |
| ---------------- | ------------------- | -------------------------------------------------------------------------------------------------------- |
| `terminal/`      | kitty + zsh + nvim  | zsh with oh-my-zsh, powerlevel10k, autosuggestions, syntax-highlighting, `eza` aliases, `fzf` shortcuts and Neovim with [LazyVim](https://www.lazyvim.org/) |
| `launcher/`      | rofi                | Application launcher (`applauncher.rasi`)                                                                |
| `wallpapers/`    | awww                | Static and animated (GIF) wallpapers with a script to cycle through them                                 |
| `waybar/`        | waybar              | Top bar: workspaces, clock, caffeine, audio, microphone, battery, tray and power button                  |
| `notifications/` | mako                | Notifications                                                                                            |
| `lock/`          | hyprlock + hypridle | Locks after 5 min of inactivity and turns the screen off after 5 min 30 s                                |
| `greeter/`       | greetd + tuigreet   | Terminal login screen                                                                                    |
| `include/`       | Lua                 | Keybinds, daemons and settings added to `hyprland.lua`                                                   |

## Requirements

- A rolling-release distribution with `pacman`.
- Hyprland already installed and **started at least once with `start-hyprland`**, so that `~/.config/hypr/hyprland.lua` exists. The installer aborts if it can't find it.
- A user with `sudo` privileges and an internet connection.

## Installation

```bash
git clone <repository-url> MinimalHypr
cd MinimalHypr
chmod +x install.sh
./install.sh
```

The script:

1. Updates the system (`pacman -Syu`) and installs `paru` if it isn't present.
2. Installs the dependencies with `pacman` and `paru` (including `kitty`, `rofi`, `waybar`, `mako`, `hyprlock`, `hypridle`, `greetd`, `neovim`, `yazi`, `zsh`, JetBrains Mono Nerd fonts, and applications such as `zen-browser`, `obsidian`, `bitwarden`, `btop`…).
3. Runs each module's script in order and shows a summary with ✔/✘.
4. Copies `include/*.lua` to `~/.config/hypr/` and appends the matching `require(...)` lines to `hyprland.lua` (only if they weren't already there).
5. Offers to reboot when finished.

> **Warning:** the installer changes your default shell to zsh, enables `greetd` as the login manager and replaces existing configurations. Read it before running it.

### Backups

Before overwriting anything, each module moves your previous configuration to `copiaseguridad/<date-time>/` inside the repository (a folder ignored by git). To restore something, copy it back from there.

## Keybinds

| Shortcut            | Action                                                                             |
| ------------------- | ---------------------------------------------------------------------------------- |
| `SUPER + Enter`     | Terminal (kitty)                                                                   |
| `SUPER + Space`     | Application launcher (rofi)                                                        |
| `SUPER + E`         | File manager (yazi)                                                                |
| `SUPER + N`         | Neovim (LazyVim)                                                                   |
| `SUPER + B`         | Browser (zen-browser)                                                              |
| `SUPER + Q`         | Close window                                                                       |
| `SUPER + F`         | Maximize / restore                                                                 |
| `SUPER + V`         | Toggle floating window                                                             |
| `SUPER + P`         | Screenshot of a region (saved to `~/Pictures/Screenshots` and copied to clipboard) |
| `SUPER + Shift + L` | Lock screen                                                                        |
| `SUPER + W`         | Next animated wallpaper                                                            |
| `SUPER + L`         | Next static wallpaper                                                              |

The keybinds live in `include/keybinds.lua`.

## Customization

- **Keybinds:** `include/keybinds.lua`
- **Gaps, opacity, touchpad:** `include/settings.lua`
- **Programs started with the session:** `include/daemons.lua`
- **Lock timeouts:** `lock/hypridle.conf`
- **Login colors:** `greeter/config.toml`
- **Wallpapers:** add images to `wallpapers/NormalWallpapers/` or GIFs to `wallpapers/LiveWallpapers/` before installing (or directly to `~/.config/awww/` afterwards).

If you change anything in the repository, re-run the module's script (for example `cd waybar && ./waybar.sh`) or the full installer to deploy it.

## Structure

```
MinimalHypr/
├── install.sh
├── include/        # keybinds.lua, daemons.lua, settings.lua
├── terminal/       # kitty.conf, terminal.sh
├── launcher/       # applauncher.rasi, launcher.sh
├── wallpapers/     # wallpapers, switcher.sh, wallpapers.sh
├── waybar/         # config.jsonc, style.css, waybar.sh
├── notifications/  # config (mako), notifications.sh
├── lock/           # hyprlock.conf, hypridle.conf, lock.sh
└── greeter/        # config.toml (greetd), greeter.sh
```

## Credits

- Wallpapers: [D3Ext/aesthetic-wallpapers](https://github.com/D3Ext/aesthetic-wallpapers)
- Rofi launcher theme (base): [adi1090x/rofi](https://github.com/adi1090x/rofi)
- Neovim configuration: [LazyVim/starter](https://github.com/LazyVim/starter)
