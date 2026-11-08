-- Terminal
hl.unbind("SUPER + RETURN")
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("kitty"))

-- Gestor de archivos
hl.unbind("SUPER + E")
hl.bind("SUPER + E", hl.dsp.exec_cmd("kitty -e yazi"))

-- Pantalla completa
hl.unbind("SUPER + F")
hl.bind(
	"SUPER + F",
	hl.dsp.window.fullscreen({
		mode = "maximized",
		action = "toggle",
	})
)

-- Neovim
hl.unbind("SUPER + N")
hl.bind("SUPER + N", hl.dsp.exec_cmd("kitty nvim"))

-- Navegador
hl.unbind("SUPER + B")
hl.bind("SUPER + B", hl.dsp.exec_cmd("zen-browser"))

-- Cerrar ventana
hl.unbind("SUPER + Q")
hl.bind("SUPER + Q", hl.dsp.window.close())

-- Ventana flotante
hl.unbind("SUPER + V")
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))

-- Captura de pantalla
hl.unbind("SUPER + P")
hl.bind(
	"SUPER + P",
	hl.dsp.exec_cmd(
		'mkdir -p "$HOME/Pictures/Screenshots" && grim -g "$(slurp)" - | tee "$HOME/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png" | wl-copy'
	)
)

-- Lanzador de aplicaciones
hl.unbind("SUPER + SPACE")
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("rofi -show drun -theme ~/.config/rofi/applauncher.rasi"))

-- Bloquear pantalla
hl.unbind("SUPER + SHIFT + L")
hl.bind("SUPER + SHIFT + L", hl.dsp.exec_cmd("loginctl lock-session"))

-- Wallpaper animado
hl.unbind("SUPER + W")
hl.bind("SUPER + W", hl.dsp.exec_cmd("~/.config/awww/switcher.sh live"))

-- Wallpaper normal
hl.unbind("SUPER + L")
hl.bind("SUPER + L", hl.dsp.exec_cmd("~/.config/awww/switcher.sh normal"))
