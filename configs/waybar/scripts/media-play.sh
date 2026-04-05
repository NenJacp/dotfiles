#!/bin/bash

# Script para mostrar icono dinámico de play/pause según el estado
STATUS=$(playerctl status 2>/dev/null)

if [ "$STATUS" = "Playing" ]; then
    echo '{"text": "󰏤", "tooltip": "Pausar"}'
elif [ "$STATUS" = "Paused" ]; then
    echo '{"text": "󰐊", "tooltip": "Reproducir"}'
else
    echo '{"text": "󰐊", "tooltip": "Reproducir"}'
fi