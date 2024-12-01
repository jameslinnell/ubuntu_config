#!/bin/bash

# Open gnome-terminal in maximized mode, run zsh, and execute NordVPN commands
#gnome-terminal --window --maximize -- zsh -c "nordvpn connect uk; nordvpn status; cd Development/NHS/CPM/connecting-party-manager; nvim; exec zsh"

# Launch the first gnome-terminal with the VPN connection and Neovim session
#gnome-terminal --window --maximize -- zsh -c "
#  nordvpn connect uk;
#  nordvpn status;
#  cd Development/NHS/CPM/connecting-party-manager;
#  nvim;
#  exec zsh
#" &

# Add a small sleep to ensure the first terminal is launched
# sleep 2

# Launch the second gnome-terminal and cd to the same directory
#gnome-terminal --window --maximize -- zsh -c "
#  cd Development/NHS/CPM/connecting-party-manager;
#  exec zsh
#"

# Check if cron service is running; if not, start it
if ! pgrep cron > /dev/null; then
    echo "Starting cron service..."
    sudo systemctl start cron
fi

echo "Cron service is running."



