#!/bin/bash
apt-get update
apt-get upgrade
apt-get -y install playonlinux software-center nano unrar

#chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
apt-get update
apt-get -y install google-chrome-stable

#skype
wget https://repo.skype.com/latest/skypeforlinux-64.deb
dpkg -i skypeforlinux-64.deb
rm -f skypeforlinux-64.deb

#viber
wget http://download.cdn.viber.com/cdn/desktop/Linux/viber.deb
dpkg -i viber.deb
rm -f viber.deb

#phpstorm
wget https://download.jetbrains.com/webide/PhpStorm-2017.2.4.tar.gz
tar xvf PhpStorm-2016.1.2.tar.gz

#notepadqq
add-apt-repository ppa:notepadqq-team/notepadqq -y
apt-get update
apt-get -y install notepadqq
