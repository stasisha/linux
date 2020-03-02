#!/bin/bash
# Ubuntu post install wrapper

# Am I root?
if [ "x$(id -u)" != 'x0' ]; then
    echo 'Error: this script can only be executed by root'
    exit 1
fi

read -p 'Would you like to upgrade system? [y/n]: ' upgrade
read -p 'Would you like to install Play On Linux? [y/n]: ' pol
read -p 'Would you like to install Software Center? [y/n]: ' osc
read -p 'Would you like to install Unrar? [y/n]: ' unrar
read -p 'Would you like to install Chrome? [y/n]: ' chrome
read -p 'Would you like to install Skype? [y/n]: ' skype
read -p 'Would you like to install Viber? [y/n]: ' viber
read -p 'Would you like to install PhpStorm? [y/n]: ' phpstorm
read -p 'Would you like to install Notepadqq? [y/n]: ' notepadqq
read -p 'Would you like to install Filezilla? [y/n]: ' filezilla

pm="apt-get"

install="${pm} -y install"

# Upgrade
if [ "$upgrade" == 'y' ] || [ "$upgrade" == 'Y'  ]; then
    eval "${pm} upgrade"
fi

# Play On Linux
if [ "$pol" == 'y' ] || [ "$pol" == 'Y'  ]; then
    eval "${install} playonlinux"
fi

# Software-center
if [ "$osc" == 'y' ] || [ "$osc" == 'Y'  ]; then
    eval "${install} software-center"
fi

# Unrar
if [ "$unrar" == 'y' ] || [ "$unrar" == 'Y'  ]; then
    eval "${install} unrar"
fi

# Chrome
if [ "$chrome" == 'y' ] || [ "$chrome" == 'Y'  ]; then
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
    eval "${pm} update"
    eval "${install} google-chrome-stable"
fi

# Skype
if [ "$skype" == 'y' ] || [ "$skype" == 'Y'  ]; then
    wget https://repo.skype.com/latest/skypeforlinux-64.deb  O /tmp/skypeforlinux-64.deb 
    dpkg -i /tmp/skypeforlinux-64.deb
    rm -f /tmp/skypeforlinux-64.deb
fi

# Viber
if [ "$viber" == 'y' ] || [ "$viber" == 'Y'  ]; then
    wget http://download.cdn.viber.com/cdn/desktop/Linux/viber.deb - O /tmp/viber.deb
    dpkg -i /tmp/viber.deb
    rm -f /tmp/viber.deb
fi

# PhpStorm
if [ "$phpstorm" == 'y' ] || [ "$phpstorm" == 'Y'  ]; then
    eval "${install} snapd snapd-xdg-openCopy"
    eval "snap install phpstorm --classic"
fi

# Notepadqq
if [ "$notepadqq" == 'y' ] || [ "$notepadqq" == 'Y'  ]; then
    add-apt-repository ppa:notepadqq-team/notepadqq -y
    eval "${pm} update"
    eval "${install} notepadqq"
fi

# FileZilla
if [ "$filezilla" == 'y' ] || [ "$filezilla" == 'Y'  ]; then
    eval "${install} filezilla"
fi
