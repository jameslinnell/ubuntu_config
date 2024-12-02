#!/bin/bash

function ubuntu_update() {
  echo "Updating system..."
  sudo apt update -y
  sudo apt upgrade -y
}

function ubuntu_base_packages() {
  echo "Installing base packages..."
  sudo apt install make awscli curl wget build-essential ubuntu-restricted-extras btop tldr atuin eza bat fzf neofetch vim neovim dconf-editor kitty alacritty python3-dev python3-pip python3-setuptools -y
}

function i3setup() {
  echo "Setting up i3..."
  sudo apt install i3 polybar feh rofi wireplumber dunst picom -y
}

function ubuntu_optional() {
  echo "Installing optional packages..."
  sudo apt install nordvpn -y
}

function prompt_user() {
  local prompt_message="$1"
  local function_to_run="$2"
  
  while true; do
    read -p "$prompt_message (Y/n): " user_input
    case $user_input in
      [Yy]*|"") # Default to 'yes' if the user presses enter without typing anything
        $function_to_run
        break
        ;;
      [Nn]*)
        echo "Skipping $function_to_run."
        break
        ;;
      *)
        echo "Please answer Y or n."
        ;;
    esac
  done
}

# Main script execution with prompts
prompt_user "Would you like to update the system?" ubuntu_update
prompt_user "Would you like to install base packages?" ubuntu_base_packages
prompt_user "Would you like to set up i3?" i3setup
prompt_user "Would you like to install optional packages (e.g., NordVPN)?" ubuntu_optional
