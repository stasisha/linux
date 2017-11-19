#!/bin/bash
apt-get update
apt-get upgrade
apt-get install playonlinux software-center nano unrar -y

#chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
apt-get update
apt-get install google-chrome-stable

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
sudo add-apt-repository ppa:notepadqq-team/notepadqq
sudo apt-get update
sudo apt-get install notepadqq
