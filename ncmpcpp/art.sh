#!/bin/sh

# Get cover art using playerctl and mpDris2
coverimg=$(playerctl -s metadata mpris:artUrl | sed 's#file://##')

# If no art is found, use this image as placeholder
if [ -z "$coverimg" ]; then
    coverimg="./nocover.png"
fi

kitty @ send-text -m "title:ncmpcppk-cover" "clear; kitty +kitten icat --clear; kitty +kitten icat --place ${ncmpcppk_cover_width}x${ncmpcppk_cover_height}@0x0 --silent --scale-up \"$coverimg\"\r"
kitty @ scroll-window -m "title:ncmpcppk-cover" end

