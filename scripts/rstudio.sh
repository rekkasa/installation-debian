#!/bin/bash

USER=$1
RSTUDIO_URL=$2
USERHOME=/home/$USER

cd $USERHOME/src
wget https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.4.1106-amd64.deb
dpkg -i *.deb
