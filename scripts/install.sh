#!/bin/bash

NAME=${1?2Error: no user given}
USERHOME=/home/$NAME

# Replace sources.list
[[ -f /etc/apt/sources.list ]] && { sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak; sudo cp $USERHOME/installation-debian/files/sources.list /etc/apt/sources.list; }
[[ -f /etc/apt/preferences ]] && { sudo cp $USERHOME/installation-debian/files/preferences /etc/apt/preferences; }

sudo apt update && sudo apt upgrade -yy
sudo apt install xorg xserver-xorg xinit build-essential libx11-dev intel-microcode \
	python3 python3-pip python-dbus libpangocairo-1.0-0 \
	materia-gtk-theme numix-icon-theme lxappearance \
	libxft-dev libxinerama-dev feh picom thunar qpdfview \
	network-manager xbacklight curl cmake pkg-config \
	libfreetype6-dev libfontconfig1-dev alsa-utils \
	libxcb-xfixes0-dev libxkbcommon-dev firefox ufw wget\
	r-cran-curl r-cran-openssl r-cran-xml2\
	libcurl4-openssl-dev libxml2-dev libssl-dev \
	fonts-dejavu fonts-inconsolata \
	flameshot apt-listbugs psmisc r-base -yy

pip3 install xcffib
pip3 install --no-cache-dir cairocffi

curl -fsSL https://starship.rs/install.sh | bash

export PATH=`pwd`:$PATH

# Create required directories
mkdir -p $USERHOME/Documents $USERHOME/Pictures $USERHOME/src/dwm \
	 $USERHOME/src/alacritty $USERHOME/.config/picom

# Fetch git repos
cd $USERHOME && git clone git://github.com/rekkasa/configs.git && \
	git clone git://github.com/rekkasa/scripts.git
cd $USERHOME/src && git clone https://git.suckless.org/dwm
cd $USERHOME/src && git clone https://git.suckless.org/dmenu
cd $USERHOME/src && git clone https://github.com/dudik/herbe.git
cd $USERHOME/src && git clone https://git.suckless.org/slstatus
cd $USERHOME/src && git clone https://github.com/qtile/qtile.git
# cd $USERHOME && git clone https://gitlab.com/dwt1/wallpapers.git
# mv $USERHOME/wallpapers/ $USERHOME/Wallpapers/
cd $USERHOME/git && git clone https://github.com/zsh-users/zsh-autosuggestions.git && \
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git

# Fonts
# echo -e "\n\nInstsalling Nerd fonts\n"
# cd $USERHOME/src && git clone https://github.com/ryanoasis/nerd-fonts.git
# $USERHOME/src/nerd-fonts/install.sh

# Setup xinit
ln -s $USERHOME/configs/xinitrc $USERHOME/.xinitrc

# Setup dwm
# ln -s $USERHOME/configs/dwm/config.h $USERHOME/src/dwm/
# cd $USERHOME/src/dwm && make

# Setup qtile
cd $USERHOME/src/qtile && pip3 install .

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
# export PATH=$USERHOME/.cargo/bin:$PATH
source $USERHOME/.cargo/env
rustup override set stable
rustup update stable
cargo build --release

# Setup .config directory
ln -s $USERHOME/configs/picom/picom.conf $USERHOME/.config/picom/
ln -s $USERHOME/configs/alacritty $USERHOME/.config/alacritty
ln -s $USERHOME/configs/.bashrc $USERHOME/.basrc


echo -e 'eval "$(starship init bash)"' >> $USERHOME/.bashrc

echo "-------------------------"
echo "| Generating symlinks    |"
echo "-------------------------"

echo -e "\n\n Symlinks\n"
# ln -s $USERHOME/src/dwm/dwm /usr/bin
sudo ln -s $USERHOME/src/dmenu/dmenu /usr/bin
sudo ln -s $USERHOME/src/dmenu/dmenu_run /usr/bin
sudo ln -s $USERHOME/src/dmenu/dmenu_path /usr/bin
sudo ln -s $USERHOME/src/dmenu/stest /usr/bin
sudo ln -s $USERHOME/src/slstatus/slstatus /usr/bin
sudo ln -s $USERHOME/src/herbe/herbe /usr/bin
sudo ln -s $USERHOME/src/alacritty/target/release/alacritty /usr/bin


# System changes
## Swappiness
# sudo echo 10 > /proc/sys/vm/swappiness
# sudo cp -p /etc/sysctl.conf /etc/sysctl.conf.`date +%Y%m%d-%H:%M`
# sudo echo "" >> /etc/sysctl.conf
# sudo echo "#Set swappiness to 10 to avoid swapping" >> /etc/sysctl.conf
# sudo echo "vm.swappiness = 10" >> /etc/sysctl.conf

