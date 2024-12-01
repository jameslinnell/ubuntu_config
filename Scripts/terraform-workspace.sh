#!/bin/bash

# Path to the environment file
ENV_FILE="$HOME/Development/NHS/CPM/connecting-party-manager/infrastructure/terraform/per_workspace/.terraform/environment"

# Check if the file exists
if [[ -f "$ENV_FILE" ]]; then
    # Output the workspace string
    cat "$ENV_FILE"
else
    # Output nothing if the file doesn't exist
    echo ""
fi

