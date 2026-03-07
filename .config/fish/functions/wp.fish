function wp
    set transition_type fade
    set transition_duration 1
    set transition_fps 90

    set current (swww query | awk -F'image: /home/cypher/Downloads/Wallpaper/' '{print $2}' | head -1)
    set wallpapers (find ~/Downloads/Wallpaper -type f \( -name "*.jpg" -o -name "*.png" \))

    for W in $wallpapers
        if not string match -q "*$current" $W
            set filtered $filtered $W
        end
    end

    set names (string replace '/home/cypher/Downloads/Wallpaper/' '' $filtered)
    set selected (string join \n $names | wofi --dmenu)

    swww img /home/cypher/Downloads/Wallpaper/$selected --transition-type $transition_type --transition-duration $transition_duration --transition-fps $transition_fps
end