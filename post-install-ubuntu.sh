#!/bin/bash
read -p 'Would you like to upgrade system? [y/n]: ' upgrade_answer
read -p 'Would you like to install Play On Linux? [y/n]: ' pol_answer
read -p 'Would you like to install Ubuntu Software Center? [y/n]: ' usc_answer
read -p 'Would you like to install Play on linux? [y/n]: ' pol_answer
read -p 'Would you like to install Play on linux? [y/n]: ' pol_answer
read -p 'Would you like to install Play on linux? [y/n]: ' pol_answer
read -p 'Would you like to install Play on linux? [y/n]: ' pol_answer
read -p 'Would you like to install Play on linux? [y/n]: ' pol_answer

#upgrade
if [ "$upgrade_answer" == 'y' ] || [ "$upgrade_answer" == 'Y'  ]; then
  apt-get update
  apt-get upgrade
fi

#playonlinux
if [ "$pol_answer" == 'y' ] || [ "$pol_answer" == 'Y'  ]; then
  apt-get -y install playonlinux
fi

#software-center 
if [ "$usc_answer" == 'y' ] || [ "$usc_answer" == 'Y'  ]; then
  apt-get -y install software-center 
fi

#unrar
if [ "$usc_answer" == 'y' ] || [ "$usc_answer" == 'Y'  ]; then
  apt-get -y install unrar
fi

#chrome
if [ "$chrome_answer" == 'y' ] || [ "$chrome_answer" == 'Y'  ]; then
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
  apt-get update
  apt-get -y install google-chrome-stable
fi

#skype
if [ "$skype_answer" == 'y' ] || [ "$skype_answer" == 'Y'  ]; then
  wget https://repo.skype.com/latest/skypeforlinux-64.deb
  dpkg -i skypeforlinux-64.deb
  rm -f skypeforlinux-64.deb
fi

#viber
if [ "$viber_answer" == 'y' ] || [ "$viber_answer" == 'Y'  ]; then
  wget http://download.cdn.viber.com/cdn/desktop/Linux/viber.deb - O /tmp/viber.deb
  dpkg -i /tmp/viber.deb
  rm -f /tmp/viber.deb
fi

#phpstorm
if [ "$phpstorm_answer" == 'y' ] || [ "$phpstorm_answer" == 'Y'  ]; then
  wget https://download.jetbrains.com/webide/PhpStorm-2017.2.4.tar.gz
  tar xvf PhpStorm-2016.1.2.tar.gz
fi

#notepadqq
if [ "$notepadqq_answer" == 'y' ] || [ "$notepadqq_answer" == 'Y'  ]; then
  add-apt-repository ppa:notepadqq-team/notepadqq -y
  apt-get update
  apt-get -y install notepadqq
fi

#filezilla
if [ "$filezilla_answer" == 'y' ] || [ "$filezilla_answer" == 'Y'  ]; then
  apt-get -y install filezilla
fi
