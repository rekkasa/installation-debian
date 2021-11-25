#!/bin/bash

NAME=${1?2Error: no user given}
USERHOME=/home/$NAME

# Symlinks    
echo -e "\n\n Symlinks\n"
ln -s $USERHOME/src/dwm/dwm /usr/bin
ln -s $USERHOME/src/dmenu/dmenu /usr/bin
ln -s $USERHOME/src/dmenu/dmenu_run /usr/bin
ln -s $USERHOME/src/dmenu/dmenu_path /usr/bin
ln -s $USERHOME/src/dmenu/stest /usr/bin
ln -s $USERHOME/src/slstatus/slstatus /usr/bin
ln -s $USERHOME/src/herbe/herbe /usr/bin
ln -s $USERHOME/src/alacritty/target/release/alacritty /usr/bin


# System changes
## Swappiness
echo 10 > /proc/sys/vm/swappiness
cp -p /etc/sysctl.conf /etc/sysctl.conf.`date +%Y%m%d-%H:%M`
echo "" >> /etc/sysctl.conf
echo "#Set swappiness to 10 to avoid swapping" >> /etc/sysctl.conf
echo "vm.swappiness = 10" >> /etc/sysctl.conf

