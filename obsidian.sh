#!/bin/sh
# Launch Obsidian from user install
cd /home/debian13/.local/share/obsidian || exit 1
exec ./obsidian --no-sandbox "$@"
