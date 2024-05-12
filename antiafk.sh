#!/bin/bash

# Configurable parameters
idle_threshold=10
mouse_move_range=(-20 20)
punch_characters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()_+-=[]{}|;:,.<>?"

# Function to move mouse randomly
move_mouse() {
    while true; do
        sleep $((RANDOM % 11 + 5)) # Random sleep between 5 to 15 seconds
        x=$((RANDOM % (${mouse_move_range[1]} - ${mouse_move_range[0]} + 1) + ${mouse_move_range[0]}))
        y=$((RANDOM % (${mouse_move_range[1]} - ${mouse_move_range[0]} + 1) + ${mouse_move_range[0]}))
        xdotool mousemove_relative --sync $x $y
    done
}

# Function to punch characters randomly
punch_characters() {
    while true; do
        sleep 1
        if [ $idle_time -ge $idle_threshold ]; then
            xdotool type "$(echo -n "$punch_characters" | shuf -n 1)"
            idle_time=0
        else
            ((idle_time++))
        fi
    done
}

# Start mouse movement in background
move_mouse &

# Start punching characters in background
punch_characters &

# Start listening for keyboard input
trap 'exit' INT TERM
idle_time=0
while true; do
    read -t 1 -n 1
    if [ $? = 0 ]; then
        idle_time=0
    else
        ((idle_time++))
        if [ $idle_time -ge $idle_threshold ]; then
            xdotool key ctrl+shift+esc
            exit
        fi
    fi
done
