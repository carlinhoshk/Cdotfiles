#!/bin/bash
# Script de menu rápido para Hyprland, usando caminhos do mount externo

edit=${EDITOR:-nano}
tty=kitty
mount_path="/run/media/carlinhoshk/6b4e5aab-f67a-4321-bc1d-5ce1cec40388/carlinhoshk/.config/hypr"
configs="$mount_path/configs"
UserConfigs="$mount_path/UserConfigs"
rofi_theme="$HOME/.config/rofi/config-edit.rasi"
msg=' ⁉️ Escolha o que fazer ⁉️'
iDIR="$mount_path/swaync/images"
scriptsDir="$mount_path/scripts"
UserScripts="$mount_path/UserScripts"

menu() {
    cat <<EOF
view/edit ENV variables
view/edit Window Rules
view/edit User Keybinds
view/edit User Settings
view/edit Startup Apps
view/edit Decorations
view/edit Animations
view/edit Laptop Keybinds
view/edit Default Keybinds
Configure Monitors (nwg-displays)
Configure Workspace Rules (nwg-displays)
Choose Hyprland Animations
Choose Monitor Profiles
Choose Rofi Themes
Search for Keybinds
EOF
}

main() {
    choice=$(menu | rofi -i -dmenu -config $rofi_theme -mesg "$msg")
    case "$choice" in
        "view/edit ENV variables") file="$UserConfigs/ENVariables.conf" ;;
        "view/edit Window Rules") file="$UserConfigs/WindowRules.conf" ;;
        "view/edit User Keybinds") file="$UserConfigs/UserKeybinds.conf" ;;
        "view/edit User Settings") file="$UserConfigs/UserSettings.conf" ;;
        "view/edit Startup Apps") file="$UserConfigs/Startup_Apps.conf" ;;
        "view/edit Decorations") file="$UserConfigs/UserDecorations.conf" ;;
        "view/edit Animations") file="$UserConfigs/UserAnimations.conf" ;;
        "view/edit Laptop Keybinds") file="$UserConfigs/Laptops.conf" ;;
        "view/edit Default Keybinds") file="$configs/Keybinds.conf" ;;
        "Configure Monitors (nwg-displays)") 
            if ! command -v nwg-displays &>/dev/null; then
                notify-send -i "$iDIR/ja.png" "E-R-R-O-R" "Instale nwg-displays primeiro"
                exit 1
            fi
            nwg-displays ;;
        "Configure Workspace Rules (nwg-displays)") 
            if ! command -v nwg-displays &>/dev/null; then
                notify-send -i "$iDIR/ja.png" "E-R-R-O-R" "Instale nwg-displays primeiro"
                exit 1
            fi
            nwg-displays ;;
        "Choose Hyprland Animations") $scriptsDir/Animations.sh ;;
        "Choose Monitor Profiles") $scriptsDir/MonitorProfiles.sh ;;
        "Choose Rofi Themes") $scriptsDir/RofiThemeSelector.sh ;;
        "Search for Keybinds") $scriptsDir/KeyBinds.sh ;;
        *) return ;;
    esac
    if [ -n "$file" ]; then
        $tty -e $edit "$file"
    fi
}

if pidof rofi > /dev/null; then
  pkill rofi
fi

main 