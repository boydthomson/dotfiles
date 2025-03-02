#!/bin/bash

# Get the ID of the touchpad device
touchpad_id=$(xinput list | grep -i "touchpad" | grep -o 'id=[0-9]*' | grep -o '[0-9]*')

if [ -z "$touchpad_id" ]; then
    echo "No touchpad found!"
    exit 1
fi

# Get the property IDs for natural scrolling and pointer speed
natural_scroll_id=$(xinput list-props "$touchpad_id" | grep -i "Natural Scrolling Enabled (" | grep -o '([0-9]*)' | grep -o '[0-9]*')
pointer_speed_id=$(xinput list-props "$touchpad_id" | grep -i "libinput Accel Speed (" | grep -o '([0-9]*)' | grep -o '[0-9]*')

if [ -z "$natural_scroll_id" ] || [ -z "$pointer_speed_id" ]; then
    echo "Could not find the required properties!"
    exit 1
fi

# Invert scrolling (natural scrolling)
xinput set-prop "$touchpad_id" "$natural_scroll_id" 1

# Get current pointer speed value
current_speed=$(xinput list-props "$touchpad_id" | grep -i "libinput Accel Speed (" | awk '{print $NF}')

# Calculate new speed (increase by 30%)
new_speed=$(echo "$current_speed + 0.4" | bc)

# Ensure speed doesn't exceed 1.0
if (( $(echo "$new_speed > 1.0" | bc -l) )); then
    new_speed=1.0
fi

# Set the new pointer speed
xinput set-prop "$touchpad_id" "$pointer_speed_id" "$new_speed"

echo "Touchpad settings updated: inverted scrolling and speed increased by 30%."

