hl.on("hyprland.start", function()
	-- Demonio de wallpapers
	hl.exec_cmd("awww-daemon")

	-- Barra superior
	hl.exec_cmd("waybar")

	-- Notificaciones
	hl.exec_cmd("mako")

	-- Bloqueo automatico por inactividad
	hl.exec_cmd("hypridle")

	-- Applets de red y bluetooth (iconos en el tray)
	hl.exec_cmd("nm-applet --indicator")
	hl.exec_cmd("blueman-applet")

	-- Agente de polkit (permisos de administrador en los applets)
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
end)
