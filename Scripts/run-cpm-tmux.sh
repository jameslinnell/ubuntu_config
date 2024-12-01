#!/bin/bash

# Bug where the conf doesn't accept that mouse is on
tmux set-option -g mouse on
# Create a new tmux session in detached mode
tmux new-session -d -s connecting-party-manager

# Split the window: The bottom pane will be 20% (80% automatically goes to the top)
# tmux split-window -v -t connecting-party-manager -p 10

# Run commands in the top pane (default after the split)
# tmux select-pane -t connecting-party-manager.0
# tmux send-keys -t connecting-party-manager "cd ~/Development/NHS/CPM/connecting-party-manager/" C-m
# tmux send-keys -t connecting-party-manager "nvim" C-m

# Run commands in the bottom pane
tmux select-pane -t connecting-party-manager.0
# tmux send-keys -t connecting-party-manager "sh ~/Scripts/run-cpm.sh --build" C-m
tmux send-keys -t connecting-party-manager "cd ~/Development/NHS/CPM/connecting-party-manager/" C-m
tmus send-keys -t connecting-party-manager "clear"

# Attach to the session
tmux attach-session -t connecting-party-manager
