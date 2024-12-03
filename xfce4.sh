#!/bin/bash

function xfce4setup() {
  echo "Setting up xfce4..."
  sudo apt install xfce4 picom -y
  # current_dir=$(pwd)
  # mkdir ~/.config/i3
  # cp -rf $current_dir/config/i3/* ~/.config/i3/
  # cp -rf $current_dir/config/polybar ~/.config/
  echo "xfce4 window manger is now installed. Log out, and on the login screen set Xfce Session to be the window manager before logging back in." 
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
prompt_user "Would you like to set up xfce4 window manager?" xfce4setup
