#!/bin/sh

choice=$(printf "Yes\nNo" | rofi -dmenu -i -p "Shutdown Termux X11?")

if [ "$choice" = "Yes" ]; then
    current_pid=$$
    pids=$(pgrep -f 'termux.x11' | grep -v $current_pid)
    if [ -n "$pids" ]; then
        kill -9 $pids
    fi
fi



#!/bin/sh

if zenity --question --title="Shutdown" --text="Shutdown Termux X11 now?"; then
    current_pid=$$
    pids=$(pgrep -f 'termux.x11' | grep -v $current_pid)
    if [ -n "$pids" ]; then
        kill -9 $pids
    fi
fi
