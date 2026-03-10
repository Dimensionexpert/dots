#!/usr/bin/env bash

background=$(grep "background" ~/.config/waybar/colors.css | awk '{print $3}' | tr -d ';')
surface=$(grep "surface" ~/.config/waybar/colors.css | awk '{print $3}' | tr -d ';')
text=$(grep " text" ~/.config/waybar/colors.css | awk '{print $3}' | tr -d ';')
muted=$(grep "muted" ~/.config/waybar/colors.css | awk '{print $3}' | tr -d ';')
active=$(grep "active" ~/.config/waybar/colors.css | awk '{print $3}' | tr -d ';')

cat > ~/.config/rofi/theme.rasi << EOF
* {
    background-col:     $background;
    surface-col:        $surface;
    text-col:           $text;
    muted-col:          $muted;
    active-col:         $active;

    background-color:   transparent;
    text-color:         @text-col;
    font:               "JetBrainsMono Nerd Font 13";
}

window {
    background-color:   @background-col;
    border-color:       @muted-col;
    border-width:       1px;
    border-radius:      12px;
    width:              380px;
    padding:            8px;
}

inputbar {
    background-color:   @surface-col;
    border-radius:      8px;
    padding:            8px 12px;
    margin:             0 0 8px 0;
    children:           [prompt, entry];
}

prompt {
    color:              @active-col;
    margin:             0 8px 0 0;
}

entry {
    color:              @text-col;
    placeholder:        "Type to filter...";
    placeholder-color:  @muted-col;
}

listview {
    background-color:   transparent;
    lines:              6;
    scrollbar:          false;
}

element {
    background-color:   transparent;
    border-radius:      8px;
    padding:            8px 12px;
}

element selected {
    background-color:   @muted-col;
    text-color:         @active-col;
}

element-text {
    color:              inherit;
}
EOF