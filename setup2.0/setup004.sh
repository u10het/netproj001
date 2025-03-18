#!/bin/bash

# Get the current Codespace name dynamically
CODESPACE_NAME=$(basename "$(pwd)")

# Define the Crafty container name
CRAFTY_CONTAINER="crafty"

# Check if Crafty is already running
if docker ps -a --format '{{.Names}}' | grep -q "^$CRAFTY_CONTAINER$"; then
    echo "Crafty container already exists. Starting it..."
    docker start $CRAFTY_CONTAINER
else
    echo "Setting up Crafty container..."

    docker run -d --name $CRAFTY_CONTAINER \
    -v "/workspaces/$CODESPACE_NAME/dockerr/crafty-data:/crafty/data" \
    -v "/workspaces/$CODESPACE_NAME/dockerr/minecraft-data:/crafty/servers" \
    -p 8443:8443 \
    -p 25565:25565 \
    -e TZ=Etc/UTC \
    -e CRAFTY_HOST=0.0.0.0 \
    registry.gitlab.com/crafty-controller/crafty-4:latest
fi

# Increased delay to allow Crafty to fully initialize
echo "Waiting for Crafty to generate credentials (50s)..."
sleep 50

# Fetch and display default credentials
echo "Fetching Crafty default login credentials..."
if docker exec -it $CRAFTY_CONTAINER cat /crafty/app/config/default-creds.txt 2>/dev/null; then
    echo "✅ Credentials fetched successfully!"
else
    echo "⚠️ Warning: Could not fetch credentials! Check manually inside the container."
fi

echo "✅ Crafty setup completed!"
