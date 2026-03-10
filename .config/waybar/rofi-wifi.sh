#!/usr/bin/env bash

if [[ "$1" == "--refresh" ]]; then
    nmcli device wifi rescan 2>/dev/null
    sleep 3
fi

list=$(nmcli -t -f SSID,SECURITY,SIGNAL,IN-USE device wifi list --rescan no \
    | awk -F: '{
        if ($4 == "*") icon = "󰤨"
        else if ($3 >= 75) icon = "󰤥"
        else if ($3 >= 50) icon = "󰤢"
        else if ($3 >= 25) icon = "󰤟"
        else icon = "󰤯"

        lock = ($2 != "") ? "󰌾 " : ""

        print icon " " lock $1 "|" $1 "|" $2
    }')

refresh="󰑐 Refresh|REFRESH|"
chosen=$(echo -e "$refresh\n$list" | rofi -dmenu -p "  WiFi" -theme ~/.config/rofi/wifi.rasi)

[[ -z "$chosen" ]] && exit 0
[[ "$chosen" == "󰑐 Refresh|REFRESH|" ]] && exec "$0" --refresh

ssid=$(echo "$chosen" | cut -d'|' -f2)
security=$(echo "$chosen" | cut -d'|' -f3)

active=$(nmcli -f NAME connection show --active | grep "$ssid")

if [[ -n "$active" ]]; then
    nmcli connection down "$ssid"
    notify-send "Network" "Disconnected from $ssid"
else
    saved=$(nmcli -f NAME connection show | grep "$ssid")

    if [[ -n "$saved" ]]; then
        nmcli device wifi connect "$ssid"
        if [[ $? -ne 0 ]]; then
            password=$(echo "" | rofi -dmenu -p "  Wrong password" -password -theme ~/.config/rofi/wifi.rasi)
            nmcli connection delete "$ssid"
            nmcli device wifi connect "$ssid" password "$password"
            notify-send "Network" "Connected to $ssid"
        else
            notify-send "Network" "Connected to $ssid"
        fi
    else
        password=$(echo "" | rofi -dmenu -p "  Password" -password -theme ~/.config/rofi/wifi.rasi)
        nmcli device wifi connect "$ssid" password "$password"
        notify-send "Network" "Connected to $ssid"
    fi
fi