#!/bin/bash

UPDATE=false
BASE_PACKAGES=false
I3=false
OPTIONAL=false

function ubuntu_update() {
  echo "Running ubuntu_update..."
  sudo apt update -y
  sudo apt upgrade -y
}

function ubuntu_base_packages() {
  echo "Installing base packages..."
  sudo apt install make awscli curl poetry wget pyenv build-essential ubuntu-restricted-extras btop tldr atuin exa bat fzf neofetch vim neovim pip dconf-editor glow kitty alacritty python3-dev python3-pip python3-setuptools distutils -y
}

function i3setup() {
  echo "Setting up i3..."
  sudo apt install i3 polybar feh rofi wireplumber dunst picom -y
}

function ubuntu_optional() {
  echo "Installing optional packages..."
  sudo apt install nordvpn
}

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --update)
      UPDATE=true
      ;;
    --base-packages)
      BASE_PACKAGES=true
      ;;
    --i3)
      I3=true
      ;;
    --optional)
      OPTIONAL=true
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
  shift
done

# Run the functions based on the options
if $UPDATE; then
  ubuntu_update
fi

if $BASE_PACKAGES; then
  ubuntu_base_packages
fi

if $I3; then
  i3setup
fi

if $OPTIONAL; then
  ubuntu_optional
fi
