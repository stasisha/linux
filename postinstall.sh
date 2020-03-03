#!/bin/bash
# Post install wrapper
#
# Currently Supported Operating Systems:
#
# MacOS
# Ubuntu
# RHEL/CentOS
# Debian

# Am I root?
if [ "x$(id -u)" != 'x0' ]; then
    echo 'Error: this script can only be executed by root'
    exit 1
fi

# Detect OS
if [[ "$OSTYPE" == "linux-gnu" ]]; then
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
elif [[ "$OSTYPE" == "darwin"* ]]; then
     # Mac OSX
    type="macos"
    pm="brew"
elif [[ "$OSTYPE" == "cygwin" ]]; then
    # POSIX compatibility layer and Linux environment emulation for Windows
    type="cygwin"
    notSupportedOS
elif [[ "$OSTYPE" == "msys" ]]; then
    type="msys"
     notSupportedOS
elif [[ "$OSTYPE" == "win32" ]]; then
    type="msys"
    notSupportedOS
elif [[ "$OSTYPE" == "freebsd"* ]]; then
    type="msys"
    notSupportedOS
else
    notSupportedOS
fi

notSupportedOS(){
    echo "OS is not supported."
    exit 1;
}

read -p 'Would you like to upgrade system? [y/n]: ' upgrade
read -p 'Would you like to install Unrar? [y/n]: ' unrar
read -p 'Would you like to install Chrome? [y/n]: ' chrome
read -p 'Would you like to install Skype? [y/n]: ' skype
read -p 'Would you like to install Viber? [y/n]: ' viber
read -p 'Would you like to install PhpStorm? [y/n]: ' phpstorm
read -p 'Would you like to install Notepadqq? [y/n]: ' notepadqq
read -p 'Would you like to install Filezilla? [y/n]: ' filezilla
read -p 'Would you like to install zsh? [y/n]: ' zsh

#functions zone
addLineToBottomIfNotExists() {
  local LINE=$1
  local FILE=$2
  grep -qF -- "$LINE" "$FILE" || echo "$LINE" | tee -a "$FILE"
}

removeLine(){
    sed -i "" -e "/^$1/d" $2
}

installxcode(){
    command -v xcode-select >/dev/null 2>&1 || {
        echo >&2 "Installing xcode-select..."
        xcode-select --install
    }
}

install-brew(){
  command -v brew >/dev/null 2>&1 || {
    echo >&2 "Installing homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  }
}

installNerdFontsLinux(){
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
}

brew-install-if-not-installed() {
  local software=$1
  local caskSoftware=$2

  # removing already installed packages from the list
  for p in $(brew list); do
    software=${software//$p/}
  done;

  for p in $(brew list); do
    caskSoftware=${caskSoftware//$p/}
  done;

  if [ -z "$software" ] && [ -z "$caskSoftware" ]; then
    echo "Nothing to install."
  else
    install-brew
    brew update

    if [ -n "$software" ]; then
      echo "Installing $software"
      brew install "$software"
    fi

    if [ -n "$caskSoftware" ]; then
      echo "Installing cask ${caskSoftware}"
      brew cask install "${caskSoftware}"
    fi

    brew cleanup
  fi
}

#end functions zone

case $type in
    macos)
        # Mac special commands
        read -p 'Would you like to install xcode-select? [y/n]: ' xcodeselect
        install-brew
        ;;
    debian)
        # Debian special commands
        read -p 'Would you like to install Software Center? [y/n]: ' osc
        read -p 'Would you like to install Play On Linux? [y/n]: ' pol
        read -p 'Would you like to install Synology Guest Tool? [y/n]: ' synology
        apt install snapd snapd-xdg-open
        echo "deb http://http.us.debian.org/debian stable main contrib non-free" >> /etc/apt/sources.list
        apt-get update
        ;;
    ubuntu)
        # Ubuntu special commands
        read -p 'Would you like to install Software Center? [y/n]: ' osc
        read -p 'Would you like to install Play On Linux? [y/n]: ' pol
        read -p 'Would you like to install Synology Guest Tool? [y/n]: ' synology
        ;;
    rhel)
        # RHEL/CentOS special commands
        read -p 'Would you like to install Software Center? [y/n]: ' osc
        read -p 'Would you like to install Play On Linux? [y/n]: ' pol
        read -p 'Would you like to install Synology Guest Tool? [y/n]: ' synology
        dhclient
        yum update
        ;;
esac

install="${pm} -y install"

# Xcode-select
if [ "$xcodeselect" == 'y' ] || [ "$xcodeselect" == 'Y'  ]; then
    install-xcode
fi

# Vesta
if [ "$vesta" == 'y' ] || [ "$vesta" == 'Y'  ]; then
    curl -O https://raw.githubusercontent.com/stasisha/vesta/master/install/vst-install.sh
    bash vst-install.sh
fi

# Upgrade
if [ "$upgrade" == 'y' ] || [ "$upgrade" == 'Y'  ]; then
    eval "${pm} upgrade"
fi

# synology
if [ "$synology" == 'y' ] || [ "$synology" == 'Y'  ]; then
    eval "${pm} qemu-guest-agent"
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
    case $(type) in
        macos)
            brew-install-if-not-installed "" phpstorm
            ;;
        debian)
            snap install phpstorm --classic
            ;;
        ubuntu)
            eval "${install} snapd snapd-xdg-openCopy"
            eval "snap install phpstorm --classic"
            ;;
        rhel)
            type="rhel"
            pm="yum"
            ;;
    esac
fi

# Notepadqq
if [ "$notepadqq" == 'y' ] || [ "$notepadqq" == 'Y'  ]; then
    case $(type) in
        debian)
            snap install notepadqq
            ;;
        ubuntu)
            add-apt-repository ppa:notepadqq-team/notepadqq -y
            eval "${pm} update"
            eval "${install} notepadqq"
            ;;
        rhel)
            type="rhel"
            pm="yum"
            ;;
    esac
fi

# FileZilla
if [ "$filezilla" == 'y' ] || [ "$filezilla" == 'Y'  ]; then
    eval "${install} filezilla"
fi

# zsh
if [ "$zsh" == 'y' ] || [ "$zsh" == 'Y'  ]; then

    #oh-my-zsh
    if [ ! -d "~/.oh-my-zsh" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi

    eval "${install} zsh fzf"

    if [ -d "${ZSH_CUSTOM}/themes/powerlevel10k" ]; then
        git -C ~$ZSH_CUSTOM/themes/powerlevel10k pull
    else
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
    fi

    curl -L https://raw.githubusercontent.com/stasisha/zsh/master/.appearance.sh -o ~/.appearance.sh

    removeLine 'source $ZSH\/oh-my-zsh.sh' ~/.zshrc
    addLineToBottomIfNotExists 'source ~/.appearance.sh' ~/.zshrc
    addLineToBottomIfNotExists 'source $ZSH/oh-my-zsh.sh' ~/.zshrc

    case $(type) in
          macos)
              cd ~/Library/Fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
              cd -
              ;;
          debian)
              installNerdFontsLinux
              ;;
          ubuntu)
              installNerdFontsLinux
              ;;
          rhel)
              installNerdFontsLinux
              ;;
    esac

    zsh -l
fi