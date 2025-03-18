#!/bin/bash

# Get the current Codespace name dynamically
CODESPACE_NAME=$(basename "$(pwd)")

# Define the files to modify
START_SH="dockerr/start.sh"
STOP_SH="dockerr/stop.sh"

# Ensure start.sh exists before modifying
if [ ! -f "$START_SH" ]; then
    echo "Error: $START_SH not found!"
    exit 1
fi

# Replace the old Codespace name in start.sh dynamically
echo "Updating start.sh with the current Codespace name ($CODESPACE_NAME)..."
sed -i "s|/workspaces/[^/]*/dockerr|/workspaces/$CODESPACE_NAME/dockerr|g" "$START_SH"

# Ensure start.sh is executable
chmod +x "$START_SH"
echo "start.sh is now executable."

# Ensure stop.sh is executable
if [ -f "$STOP_SH" ]; then
    chmod +x "$STOP_SH"
    echo "stop.sh is now executable."
else
    echo "Warning: $STOP_SH not found, skipping."
fi

echo "setup003.sh execution completed."
