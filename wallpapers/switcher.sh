#!/bin/bash

# Este es el script que se ejecuta para cambiar de wallpapers

modo_operacion=$1 # Esto me dice si quiero cambiar a un fondo animado o normal (0 normal, 1 animado)
contador=-1

fondo_actual=$(basename $(awww query | sed -n 's/.*currently displaying: image: //p' | sort -u))
extension=$(echo "$fondo_actual" | sed 's/.*\.//')

if [[ "$extension" == "gif" && "$modo_operacion" == "live" ]]; then
  echo "Estamos en modo animado y nos mantenemos en el"
  fondos=(~/.config/awww/LiveWallpapers/*)

elif [[ "$extension" == "gif" && "$modo_operacion" == "normal" ]]; then
  echo "Estamos en modo animado y cambiamos a modo normal"
  fondos=(~/.config/awww/NormalWallpapers/*)

elif [[ "$extension" != "gif" && "$modo_operacion" == "live" ]]; then
  echo "Estamos en modo normal y cambiamos a modo live"
  fondos=(~/.config/awww/LiveWallpapers/*)

elif [[ "$extension" != "gif" && "$modo_operacion" == "normal" ]]; then
  echo "Estamos en modo normal y nos mantenemos en el"
  fondos=(~/.config/awww/NormalWallpapers/*)
fi

longitud_array=${#fondos[@]}

if (($longitud_array == 0)); then
  echo "No hay fondos" >&2
  exit 1
fi

echo "Fondo acutual ---> $fondo_actual"
for fondo in "${fondos[@]}"; do
  ((contador++))
  if [[ "$fondo_actual" == "$(basename $fondo)" ]]; then
    break
  fi
done
if ((($contador + 1) == $longitud_array)); then
  awww img --resize crop --transition-type random "${fondos[0]}"
else
  echo "Fondo siguiente ---> "${fondos[($contador + 1)]}""
  awww img --resize crop --transition-type random "${fondos[($contador + 1)]}"
fi
exit 0
