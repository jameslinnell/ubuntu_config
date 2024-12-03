# Ubuntu Config

## Overview

## Table of Contents

1. [Setup](#setup)
    1. [Prerequisites](#prerequisites)
    2. [Build](#build)
    3. [Configure](#configure)

---

## Setup

### Prerequisites

 - Download and install `Ubuntu 24.10` either on a physical machine or in a virtual machine if you would like to try it out.
Once you have installed `Ubuntu 24.10` and rebooted back into the OS you will need to install `Git`

 - Open the `terminal` app.

    - To do this either click on the icon in the bottom left of the screen and find the terminal app or press the `<leader>` key.

 - In the terminal type the following command.

```
sudo apt install git -y
```
Type your password when prompted.

 - Now clone the repository to your home directory

```
git clone https://github.com/jameslinnell/ubuntu_config.git
```

### Build

 - Build the base system and base tools and follow the prompts

```
./init.sh
```
Once this is complete you will see a display in ascii art saying, `oh my zsh ....is now installed!`
 - type 
```
exit (followed by Return/Enter key)

```
You are now back in the bash terminal. 

### Configure

 - Now we can do some configuration of fonts, colours, keybindings, default apps etc.
```
./config.sh
```
 - Close the terminal and open a better one, I suggest `kitty` although it doesn't seem to play well on Virtual Machines so also try `alacritty`

### Window Manager
 - Now we have the choice to setup a different Window Manager. Once you have opened a terminal, navigate to...
```
cd ~/ubuntu_config
```

#### i3
i3wm is a tiling window manager if you're not used to a TWM it can be confusing at first, but the effort is worth it.
 - To install type...
```
./i3wm.sh
```
 - Once installed. Log out, and on the login screen select i3 and re-login. 
