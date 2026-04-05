#!/bin/bash

STATUS=$(playerctl status 2>/dev/null)

if [ "$STATUS" = "Playing" ] || [ "$STATUS" = "Paused" ]; then
    echo '{"text": "󰒭", "tooltip": "Siguiente canción"}'
else
    echo ""
fi