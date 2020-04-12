#!/bin/bash

echo "Uninstalling ALCPlugFix."

if sudo test ! -w "/"; then
sudo mount -uw /
sudo killall Finder
fi
sudo rm /usr/bin/ALCPlugFix
sudo rm /usr/bin/hda-verb
sudo launchctl unload -w /Library/LaunchAgents/good.win.ALCPlugFix.plist
sudo launchctl remove good.win.ALCPlugFix
sudo rm /Library/LaunchAgents/good.win.ALCPlugFix.plist

echo "Done, Restart your computer"
exit 0
