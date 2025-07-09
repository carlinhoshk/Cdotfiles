#!/bin/bash

# Script para captura de tela direta sem pop-ups
# TODO: Captura de tela automática

# Diretório para salvar screenshots
SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SCREENSHOT_DIR"

# Função para gerar nome único do arquivo
generate_filename() {
    local prefix="$1"
    local timestamp=$(date +"%Y%m%d_%H%M%S")
    local filename="${prefix}_${timestamp}.png"
    echo "$SCREENSHOT_DIR/$filename"
}

# Função para captura de área selecionada
capture_area() {
    local filename=$(generate_filename "area")
    grim -g "$(slurp)" "$filename"
    if [ $? -eq 0 ]; then
        notify-send "Screenshot salvo" "$filename" -t 2000
    fi
}

# Função para captura de monitor
capture_monitor() {
    local filename=$(generate_filename "monitor")
    grim "$filename"
    if [ $? -eq 0 ]; then
        notify-send "Screenshot salvo" "$filename" -t 2000
    fi
}

# Função para captura de janela focada
capture_window() {
    local filename=$(generate_filename "window")
    local window_geometry=$(hyprctl activewindow -j | jq -r '.at[0], .at[1], .size[0], .size[1]')
    if [ "$window_geometry" != "null" ]; then
        grim -g "$window_geometry" "$filename"
        if [ $? -eq 0 ]; then
            notify-send "Screenshot salvo" "$filename" -t 2000
        fi
    fi
}

# Função para captura de área com delay
capture_area_delayed() {
    local filename=$(generate_filename "area_delayed")
    sleep 3
    grim -g "$(slurp)" "$filename"
    if [ $? -eq 0 ]; then
        notify-send "Screenshot salvo" "$filename" -t 2000
    fi
}

# Função para captura de monitor com delay
capture_monitor_delayed() {
    local filename=$(generate_filename "monitor_delayed")
    sleep 3
    grim "$filename"
    if [ $? -eq 0 ]; then
        notify-send "Screenshot salvo" "$filename" -t 2000
    fi
}

# Verificar argumento
case "$1" in
    "area")
        capture_area
        ;;
    "monitor")
        capture_monitor
        ;;
    "window")
        capture_window
        ;;
    "area_delayed")
        capture_area_delayed
        ;;
    "monitor_delayed")
        capture_monitor_delayed
        ;;
    *)
        echo "Uso: $0 {area|monitor|window|area_delayed|monitor_delayed}"
        exit 1
        ;;
esac 