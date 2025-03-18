#!/bin/bash

# Define source and destination paths
GIT_FILE_DIR="dockerr/git-file/dockerr"
PLAYIT_SRC="$GIT_FILE_DIR/playit"
PLAYIT_DEST="dockerr/playit"
MAIN_DEST="dockerr"

# Ensure source directories exist
if [ ! -d "$PLAYIT_SRC" ] || [ ! -d "$PLAYIT_DEST" ]; then
    echo "Error: One or more required directories do not exist!"
    exit 1
fi

# Move all files from git-file/dockerr/playit/ to dockerr/playit/
echo "Moving files from $PLAYIT_SRC to $PLAYIT_DEST..."
mv "$PLAYIT_SRC"/* "$PLAYIT_DEST"/
echo "Playit files moved successfully."

# Move start.sh and stop.sh from git-file/dockerr/ to dockerr/
echo "Moving start.sh and stop.sh to $MAIN_DEST..."
mv "$GIT_FILE_DIR/start.sh" "$GIT_FILE_DIR/stop.sh" "$MAIN_DEST"/
echo "Start and stop scripts moved successfully."

# Make sure Playit executable
chmod +x "$PLAYIT_DEST/playit"
echo "Playit is now executable."

echo "setup002.sh execution completed."
