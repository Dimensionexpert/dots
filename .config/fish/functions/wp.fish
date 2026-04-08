function wp
    set transition_type fade
    set transition_duration 1
    set transition_fps 90

    set wallpapers (find ~/Downloads/Wallpaper -type f \( -name "*.jpg" -o -name "*.png" \))
    set names (string replace '/home/cypher/Downloads/Wallpaper/' '' $wallpapers)
    set selected (string join \n $names | rofi -dmenu -p "  Wallpaper" -theme ~/.config/rofi/theme.rasi)
    echo /home/cypher/Downloads/Wallpaper/$selected > ~/.local/share/wallpaper-last

    awww img /home/cypher/Downloads/Wallpaper/$selected \
        --transition-type $transition_type \
        --transition-duration $transition_duration \
        --transition-fps $transition_fps

    matugen image /home/cypher/Downloads/Wallpaper/$selected
    ~/.config/rofi/generate-wifi-theme.sh  
    killall -SIGUSR2 waybar
    pkill -USR1 -f kitty

end