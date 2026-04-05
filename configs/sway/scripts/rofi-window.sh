#!/usr/bin/env bash

# Obtener lista de ventanas de sway
swaymsg -t get_tree |
  jq -r '
    recurse(.nodes[]?, .floating_nodes[]?) 
    | select(.window_properties? != null) 
    | "\(.id) \(.window_properties.class) - \(.name)"
  ' |
  rofi -dmenu -i -p "Windows:" -theme ~/.config/rofi/themes/icon-menu.rasi |
  awk "{print \$1}" |
  xargs -r swaymsg "[con_id=\"] focus"
