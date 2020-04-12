#!/bin/bash

echo 'Installing ALCPlugFix'

if sudo test ! -w "/"; then
sudo mount -uw /
sudo killall Finder
fi
path=${0%/*}
sudo cp -a "$path/ALCPlugFix" /usr/bin/
sudo chmod 755 /usr/bin/ALCPlugFix
sudo chown root:wheel /usr/bin/ALCPlugFix
sudo cp -a "$path/hda-verb" /usr/bin/
sudo chmod 755 /usr/bin/hda-verb
sudo chown root:wheel /usr/bin/hda-verb
sudo cp -a "$path/good.win.ALCPlugFix.plist" /Library/LaunchAgents/
sudo chmod 644 /Library/LaunchAgents/good.win.ALCPlugFix.plist
sudo chown root:wheel /Library/LaunchAgents/good.win.ALCPlugFix.plist
sudo launchctl load /Library/LaunchAgents/good.win.ALCPlugFix.plist
echo 'Installation completed'
echo 'Restart your computer'
exit 0