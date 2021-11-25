#!/bin/bash

NAME=${1?2Error: no user given}
USERHOME=/home/$NAME

# Replace sources.list
[[ -f /etc/apt/sources.list ]] && { mv /etc/apt/sources.list /etc/apt/sources.list.bak; cp $USERHOME/installation-debian/files/sources.list /etc/apt/sources.list; }
[[ -f /etc/apt/preferences ]] && { cp $USERHOME/installation-debian/files/preferences /etc/apt/preferences; }

apt update && apt upgrade -yy
apt install xorg xinit build-essential libx11-dev intel-microcode \
	libxft-dev libxinerama-dev feh picom thunar \
	network-manager xbacklight curl cmake pkg-config \
	libfreetype6-dev libfontconfig1-dev alsa-utils \
	libxcb-xfixes0-dev python3 firefox ufw wget\
	r-cran-curl r-cran-openssl r-cran-xml2\
	libcurl4-openssl-dev\
	flameshot apt-listbugs psmisc r-base -yy

curl -fsSL https://starship.rs/install.sh | bash
