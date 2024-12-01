#!/bin/bash

# Function to check VPN connection status
check_vpn_status() {
    # Get the output of 'nordvpn status'
    status=$(nordvpn status)
    
    # Check if the VPN is connected by looking for the word 'Connected'
    if echo "$status" | grep -q "Status: Connected"; then
        echo "VPN is connected."
    else
        echo "VPN is not connected. Reconnecting..."
        # Reconnect to the UK server
        nordvpn connect uk
    fi
}

# Run the function to check VPN status and reconnect if necessary
check_vpn_status
