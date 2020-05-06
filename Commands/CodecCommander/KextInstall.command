#!/bin/bash

echo 'Installing CodecCommander.kext to /Library/Extensions'

if sudo test ! -w "/"; then
sudo mount -uw /
sudo killall Finder
fi
path=${0%/*}
sudo cp -a "$path/CodecCommander.kext" /Library/Extensions
sudo chmod 755 /Library/Extensions/CodecCommander.kext
sudo chown root:wheel /Library/Extensions/CodecCommander.kext
sudo chown -v -R root:wheel /System/Library/Extensions
sudo touch /System/Library/Extensions
sudo chmod -v -R 755 /Library/Extensions
sudo chown -v -R root:wheel /Library/Extensions
sudo touch /Library/Extensions
sudo kextcache -i /
echo 'CodecCommander.kext has been installed in /Library/Extensions'
echo 'Restart your computer'
exit 0
