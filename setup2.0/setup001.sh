#!/bin/bash

# Step 1: Create the required folder structure
mkdir -p dockerr/git-file
mkdir -p dockerr/minecraft-data
mkdir -p dockerr/playit

# Step 2: Clone the correct repository inside git-file folder
if [ ! -d "dockerr/git-file/.git" ]; then
    git clone https://github.com/u10het/netproj001 dockerr/git-file
else
    echo "Repository already exists in git-file. Skipping clone."
fi

echo "Setup001.sh execution completed."

