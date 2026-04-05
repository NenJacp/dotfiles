#!/bin/bash

layout=$(swaymsg -t get_inputs | jq -r '.[] | select(.type == "keyboard") | .xkb_active_layout_name' | head -1)

case "$layout" in
    "English (US)"|"US"|"us")
        echo "󰌌 US"
        ;;
    "Spanish"|"es"|"ES"|"latam"|"Latin American")
        echo "󰌌 ES"
        ;;
    *)
        echo "󰌌 ${layout:0:2}"
        ;;
esac
