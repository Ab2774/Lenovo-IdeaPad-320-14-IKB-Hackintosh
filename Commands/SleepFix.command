#!/bin/bash

echo 'Fixing sleep by setting hibernatemode to 0'

if sudo test ! -w "/"; then
sudo mount -uw /
sudo killall Finder
fi
path=${0%/*}
sudo pmset -a hibernatemode 0
sudo rm /var/vm/sleepimage
sudo mkdir /var/vm/sleepimage
echo 'Sleep has been fixed'
echo 'Restart your computer'
exit 0
