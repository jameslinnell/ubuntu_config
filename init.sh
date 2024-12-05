#!/bin/bash

function install_zsh() {
  sudo chsh -s /usr/bin/zsh
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="strug"/g' $HOME/.zshrc
  echo "ZSH now installed please rerun to carry on"
}

function ubuntu_update() {
  echo "Updating system..."
  sudo apt update -y
  sudo apt upgrade -y
}

function ubuntu_base_packages() {
  echo "Installing base packages..."
  sudo apt install zsh fd-find make awscli curl file wget build-essential ubuntu-restricted-extras btop tldr atuin eza bat fzf neofetch vim neovim dconf-editor kitty alacritty python3-dev python3-pip python3-setuptools -y
  install_zsh
}

function prompt_user() {
  local prompt_message="$1"
  local function_to_run="$2"

  while true; do
    read -p "$prompt_message (Y/n): " user_input
    case $user_input in
    [Yy]* | "") # Default to 'yes' if the user presses enter without typing anything
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
