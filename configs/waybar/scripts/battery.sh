#!/usr/bin/env bash

# Obtener estado actual
current_profile=$(powerprofilesctl get)
charging=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "state" | awk '{print $2}')
percentage=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "percentage" | awk '{print $2}' | sed 's/%//')

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
echo "{\"text\": \"$icon $percentage% \", \"tooltip\": \"Battery: $percentage%\\nProfile: $current_profile\\nState: $charging\"}"
