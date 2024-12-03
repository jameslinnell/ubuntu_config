#!/bin/bash

function install_lazygit() {
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit -D -t /usr/local/bin/
}

function add_to_rc_files() {
  local lines=("$@")
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
  add_to_rc_files "alias lg=lazygit" "alias vim=nvim" "alias nvf='nvim \$(fzf)'" "alias cat=batcat" "alias bfz='batcat \$(fzf)'" "alias lsls='exa -h -a -1 -l -r --sort name --tree -L 1 --group-directories-first --total-size --time-style iso --git --icons=auto'" "alias ls='exa -h -a -1 -l -r --sort name --tree -L 1 --group-directories-first --total-size --time-style iso --git --no-permissions --no-user --no-time --icons=auto'" "alias cdf='cd \$(find . -type d | fzf)'"
}

function add_defaults() {
	add_to_rc_files " " ". '~/.atuin/bin/env'" "export EDITOR=nvim" "export VISUAL=nvim" " " "export PATH=~/.local/bin:$PATH"
	echo 'eval "$(atuin init zsh)"' >> ~/.zshrc
}

function install_asdf() {
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1
}

function install_starship() {
  curl -sS https://starship.rs/install.sh | sh
  echo 'eval "$(starship init zsh)"' >> ~/.zshrc
  current_dir=$(pwd)
  cp -rf $current_dir/config/kitty ~/.config/
  sudo apt install stow -y
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Cousine.zip
  unzip Cousine.zip -d ~/.local/share/fonts
  fc-cache -fv
}

function install_config() {
  current_dir=$(pwd)
  cp -rf $current_dir/config/rofi ~/.config/
  cp -rf $current_dir/config/dunst ~/.config/
  cp -rf $current_dir/config/atuin ~/.config/
  cp -rf $current_dir/config/starship.toml ~/.config/
  cp -rf $current_dir/config/picom.conf ~/.config/
}

function wallpapers() {
  current_dir=$(pwd)
  cp -rf $current_dir/wallpapers ~/Pictures/
}

function ubuntu_config() {
  install_lazygit
  install_asdf
  sed -i 's/plugins=(git)/plugins=(git asdf)/g' ~/.zshrc
  add_aliases
  add_defaults
  install_starship
}

function i3setup() {
  echo "Setting up i3..."
  sudo apt install i3 polybar feh rofi wireplumber dunst picom -y
  current_dir=$(pwd)
  mkdir ~/.config/i3
  cp -rf $current_dir/config/i3/* ~/.config/i3/
  cp -rf $current_dir/config/polybar ~/.config/
  echo "i3 window manger is now installed. Log out, and on the login screen set i3 to be the window manager before logging back in." 
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
prompt_user "Would you like to configure the system?" ubuntu_config
prompt_user "Would you like to set up i3?" i3setup
prompt_user "Would you like to install extra config?" install_config
prompt_user "Would you like to install wallpapers?" wallpapers
prompt_user "Would you like to install optional packages (e.g., NordVPN)?" ubuntu_optional
