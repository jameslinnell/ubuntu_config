#!/bin/bash

function install_lazygit() {
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit -y -D -t /usr/local/bin/
}

function add_to_rc_files() {
  local lines = $1
  # local lines=("export MY_VAR1='value1'"
  #              "export MY_VAR2='value2'"
  #              "alias ll='ls -la'")

  local files=("$HOME/.zshrc" "$HOME/.bashrc")

  for file in "${files[@]}"; do
    echo "Adding lines to $file..."
    for line in "${lines[@]}"; do
      echo "$line" >> "$file"
    done
    echo "Lines added to $file"
  done
}

function add_aliases() {
  local lines=("alias lg=lazygit"
               "alias vim=nvim"
               "alias nvf='nvim \$(fzf)'"
               "alias cat=batcat"
               "alias bfz='batcat \$(fzf)'"
               "alias lsls='exa -h -a -1 -l -r --sort name --tree -L 1 --group-directories-first --total-size --time-style iso --git --icons=auto'"
               "alias ls='exa -h -a -1 -l -r --sort name --tree -L 1 --group-directories-first --total-size --time-style iso --git --no-permissions --no-user --no-time --icons=auto'"
               "alias cdf='cd \$(find . -type d | fzf)'")
  add_to_rc_files $lines
}

function install_zsh() {
  sudo chsh -s /usr/bin/zsh
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="strug"/g' $HOME/.zshrc
}

function install_asdf() {
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1
}

function ubuntu_update() {
  echo "Updating system..."
  sudo apt update -y
  sudo apt upgrade -y
}

function ubuntu_base_packages() {
  echo "Installing base packages..."
  sudo apt install zsh make awscli curl file wget build-essential ubuntu-restricted-extras btop tldr atuin eza bat fzf neofetch vim neovim dconf-editor kitty alacritty python3-dev python3-pip python3-setuptools -y
  install_lazygit
  install_zsh
  install_asdf
  sed -i 's/plugins=(git)/plugins=(git asdf)/g' >> $HOME/.zshrc
  add_aliases
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
