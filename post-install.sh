#!/bin/bash
# Linux post install wrapper
#
# Currently Supported Operating Systems:
#
# Ubuntu
# RHEL/CentOS
# Debian

# Am I root?
if [ "x$(id -u)" != 'x0' ]; then
    echo 'Error: this script can only be executed by root'
    exit 1
fi

# Detect OS
case $(head -n1 /etc/issue | cut -f 1 -d ' ') in
    Debian)
        type="debian"
        pm="apt-get"
        ;;
    Ubuntu)
        type="ubuntu"
        pm="apt-get"
        ;;
    *)
        type="rhel"
        pm="yum"
        ;;
esac

install="${pm} -y install"

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
read -p 'Would you like to install Vesta? [y/n]: ' vesta

# Vesta
if [ "$upgrade" == 'y' ] || [ "$upgrade" == 'Y'  ]; then
    curl -O https://raw.githubusercontent.com/stasisha/vesta/master/install/vst-install.sh
    bash vst-install.sh
fi

# Upgrade
if [ "$upgrade" == 'y' ] || [ "$upgrade" == 'Y'  ]; then
    eval "${pm} update"
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
if [ "$osc" == 'y' ] || [ "$unrar" == 'Y'  ]; then
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
    wget https://repo.skype.com/latest/skypeforlinux-64.deb
    dpkg -i skypeforlinux-64.deb
    rm -f skypeforlinux-64.deb
fi

# Viber
if [ "$viber" == 'y' ] || [ "$viber" == 'Y'  ]; then
    wget http://download.cdn.viber.com/cdn/desktop/Linux/viber.deb - O /tmp/viber.deb
    dpkg -i /tmp/viber.deb
    rm -f /tmp/viber.deb
fi

# PhpStorm
if [ "$phpstorm" == 'y' ] || [ "$phpstorm" == 'Y'  ]; then
    wget https://download.jetbrains.com/webide/PhpStorm-2017.2.4.tar.gz
    tar xvf PhpStorm-2016.1.2.tar.gz
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
