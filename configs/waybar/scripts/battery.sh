#!/usr/bin/env bash

# Intentar detectar el dispositivo de batería
battery_dev=$(upower -e | grep 'BAT' | head -n 1)

if [ -z "$battery_dev" ]; then
    # No hay batería (posiblemente un VM)
    echo '{"text": "󰂄 AC", "tooltip": "Corriente Alterna - No se detectó batería"}'
    exit 0
fi

# Obtener estado actual
current_profile=$(powerprofilesctl get 2>/dev/null || echo "balanced")
charging=$(upower -i "$battery_dev" | grep "state" | awk '{print $2}')
percentage=$(upower -i "$battery_dev" | grep "percentage" | awk '{print $2}' | sed 's/%//')

# Si percentage está vacío, poner 0
[ -z "$percentage" ] && percentage=0

# Determinar icono según el perfil de energía
if [[ "$charging" == "charging" || "$charging" == "fully-charged" ]]; then
  icon="󰚥"
elif [[ "$percentage" -lt 20 ]]; then
  icon=""
elif [[ "$current_profile" == "power-saver" ]]; then
  icon="󰌪"
elif [[ "$current_profile" == "performance" ]]; then
  icon="󱐋"
else # balanced
  case $((percentage / 10)) in
  0) icon="󰁺" ;;
  1) icon="󰁻" ;;
  2) icon="󰁼" ;;
  3) icon="󰁽" ;;
  4) icon="󰁾" ;;
  5) icon="󰁿" ;;
  6) icon="󰂀" ;;
  7) icon="󰂁" ;;
  8) icon="󰂂" ;;
  9) icon="󰁹" ;;
  *) icon="󰁹" ;;
  esac
fi

# Salida JSON para waybar
echo "{\"text\": \"$icon $percentage% \", \"tooltip\": \"Batería: $percentage%\\nPerfil: $current_profile\\nEstado: $charging\"}"
