#!/bin/bash

# Save the working directory to return to
olddir="$PWD"
# Move to ncmpcpp config dir
cd ~/.config/ncmpcpp

function main() {
    
    echo "" > ./log

    # Get terminal width and height
    term_w=$(tput cols)
    term_h=$(tput lines)
    
    # Set up window size calculations
    calculate_sizes

    # Launch all the other windows in the program
    initialize_layout
   
    # Display cover art
    ./art.sh

    # Finally launch ncmpcpp
    ncmpcpp -q "$@"
       
    # Clean up once ncmpcpp closes
    cleanup
}

function calculate_sizes() {

    # Cover image size
    export ncmpcppk_cover_width=$((term_w / 4))
    export ncmpcppk_cover_height=$((term_w / 8))

    # Calculate amount to resize the cover panel horizontally
    # and vertically, in order to get a mostly square frame for the cover.
    cover_resize_amount_h=$(bc -l <<< "-1 * ($ncmpcppk_cover_width - ($term_w / 32) + 1)" | xargs printf "%.0f")
    cover_resize_amount_v=$(bc -l <<< "-1 * (($term_h / 2) - $ncmpcppk_cover_height - 1)" | xargs printf "%.0f")
    # Turn -0 into 0
    if [ "$cover_resize_amount_h" == "-0" ]; then
        cover_resize_amount_h=0
    fi
    if [ "$cover_resize_amount_v" == "-0" ]; then
        cover_resize_amount_v=0
    fi
}

function initialize_layout() {
    do_resize=0
    
    #Use split layout
    kitty @ goto-layout splits
    kitty @ set-window-title "ncmpcppk"
    
    # Show cover art
    nohup kitty @ launch --title "ncmpcppk-cover" --cwd=current --location=before sh -i <<< "exec </dev/tty" &> /dev/null
    # Show lyrics
    nohup kitty @ launch --title "ncmpcppk-lyrics" --location=hsplit sh -c "lyvi" &> /dev/null
    
    # Refocus main ncmpcpp window and show visualization
    kitty @ focus-window -m  "title:^(ncmpcppk)$"
    nohup kitty @ launch --keep-focus --title "ncmpcppk-vis" --location=hsplit cava &> /dev/null

    # Resize windows
    resize
    do_resize=1
}

function resize() {

    # Make visualizer 1/8th terminal height
    kitty @ resize-window -m "title:ncmpcppk-vis" -i -$(((term_h / 8) * 3)) -a vertical
   
    # Resize cover
    if [ "$cover_resize_amount_h" != "0" ]; then
        kitty @ resize-window -m "title:ncmpcppk-cover" -i "$cover_resize_amount_h" -a horizontal
    fi
    if [ "$cover_resize_amount_v" != "0" ]; then
        kitty @ resize-window -m "title:ncmpcppk-cover" -i "$cover_resize_amount_v" -a vertical
        kitty @ scroll-window -m "title:ncmpcppk-cover" start
    fi
}

function cleanup() {
    monitor_resize=0
    unset ncmpcppk_cover_width
    unset ncmpcppk_cover_height
    
    # Close visualization windows
    nohup kitty @ close-window -m "title:ncmpcppk-cover" &> /dev/null
    nohup kitty @ close-window -m "title:ncmpcppk-lyrics" &> /dev/null
    nohup kitty @ close-window -m "title:ncmpcppk-vis" &> /dev/null
    # Reset terminal size for kitty
    kitty @ resize-window -a reset
    cd "$olddir"
}

main
