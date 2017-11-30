Linux Post Install Script
==================================================
How to install
----------------------------
Download the installation script:
```bash
if [ -e '/usr/bin/curl' ]; then curl -O https://raw.githubusercontent.com/stasisha/linux-desktop-postinstall/master/post-install.sh else wget https://raw.githubusercontent.com/stasisha/linux-desktop-postinstall/master/post-install.sh fi
```
Then run it:
```bash
bash post-install.sh
```