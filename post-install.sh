#!/bin/bash
#!/bin/bash
# Linux post install wrapper
#
# Currently Supported Operating Systems:
#
#  Ubuntu
#

# Am I root?
if [ "x$(id -u)" != 'x0' ]; then
    echo 'Error: this script can only be executed by root'
    exit 1
fi

# Detect OS
case $(head -n1 /etc/issue | cut -f 1 -d ' ') in
    Debian)     type="debian" ;;
    Ubuntu)     type="ubuntu" ;;
    *)          type="rhel" ;;
esac

# Check wget
if [ -e '/usr/bin/wget' ]; then
    wget https://raw.githubusercontent.com/stasisha/teamcity/master/teamcity-install-$type.sh -O teamcity-install-$type.sh
    if [ "$?" -eq '0' ]; then
        bash teamcity-install-$type.sh $*
        exit
    else
        echo "Error: teamcity-install-$type.sh download failed."
        exit 1
    fi
fi

# Check curl
if [ -e '/usr/bin/curl' ]; then
    curl -O https://raw.githubusercontent.com/stasisha/teamcity/master/teamcity-install-$type.sh
    if [ "$?" -eq '0' ]; then
        bash teamcity-install-$type.sh $*
        exit
    else
        echo "Error: teamcity-install-$type.sh download failed."
        exit 1
    fi
fi

exit
