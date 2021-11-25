#!/bin/bash

NAME=${1?2Error: no user given}
USERHOME=/home/$NAME

# export USERHOME
export PATH=`pwd`:$PATH

# Create required directories
mkdir -p $USERHOME/Documents $USERHOME/Pictures $USERHOME/src/dwm \
	 $USERHOME/src/alacritty $USERHOME/.config/picom

# Fetch git repos
cd $USERHOME && git clone https://gitlab.com/arekkas/configs.git && \
	git clone https://gitlab.com/arekkas/scripts.git
cd $USERHOME/src && git clone https://git.suckless.org/dwm
cd $USERHOME/src && git clone https://git.suckless.org/dmenu
cd $USERHOME/src && git clone https://github.com/dudik/herbe.git
cd $USERHOME/src && git clone https://git.suckless.org/slstatus
cd $USERHOME && git clone https://gitlab.com/dwt1/wallpapers.git
mv $USERHOME/wallpapers/ $USERHOME/Wallpapers/

# Fonts
echo -e "\n\nInstsalling Nerd fonts\n"
cd $USERHOME/src && git clone https://github.com/ryanoasis/nerd-fonts.git
$USERHOME/src/nerd-fonts/install.sh

# Setup xinit
ln -s $USERHOME/configs/xinitrc $USERHOME/.xinitrc

# Setup dwm
ln -s $USERHOME/configs/dwm/config.h $USERHOME/src/dwm/
cd $USERHOME/src/dwm && make

# Setup dmenu
cd $USERHOME/src/dmenu && make

# Setup slstatus
ln -s $USERHOME/configs/slstatus/config.h $USERHOME/src/slstatus
cd $USERHOME/src/slstatus && make

# Setup herbe
## Link here to personal setup of herbe when available
cd $USERHOME/src/herbe && make

# Setup alacritty
echo -e "\n\n BUILDING ALACRITTY\n"
git clone https://github.com/alacritty/alacritty.git $USERHOME/src/alacritty
cd $USERHOME/src/alacritty && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $USERHOME/.cargo/env
rustup override set stable
rustup update stable
cargo build --release

# Setup .config directory
ln -s $USERHOME/configs/picom/picom.conf $USERHOME/.config/picom/
ln -s $USERHOME/configs/alacritty $USERHOME/.config/alacritty
ln -s $USERHOME/configs/.bashrc $USERHOME/.basrc


echo -e 'eval "$(starship init bash)"' >> $USERHOME/.bashrc
