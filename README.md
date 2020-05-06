# Lenovo IdeaPad 320-14IKB (80XK) Hackitnosh 
[![Release](https://img.shields.io/badge/download-release-blue.svg)](https://github.com/Ab2774/Lenovo-Ideapad-320-Hackintosh/releases)
[![Chat](https://img.shields.io/badge/chat-tonymacx86-red.svg)](https://www.tonymacx86.com/threads/guide-lenovo-ideapad-320-14ikb-clover-uefi-hotpatch.293387/)


A guide for installing macOS Catalina on Lenovo IdeaPad 320-14IKB using Clover and Opencore UEFI hotpatch.
![](Images/Laptop.png)


# Note 
I'm not an expert in hackintoshing, this is my first Hackintosh, I managed to get everything working in my laptop, your laptop may be different than mine, higher specs, dedicated GPU, etc, it's not guaranteed to work a %100, if it's so then this guide may not work for you, so be careful and good luck!

# Laptop's Hardware 
- <b>CPU</b>: Intel i5 7200U Dual-Core CPU (Kaby Lake-U)
- <b>GPU</b>: Intel HD 620 Graphics 
- <b>Storage</b>: 500GB WD Blue Solid State Drive & 2 TB Seagate Mobile Hard Drive (Upgraded)
- <b>RAM</b>: 12 GB DDR4 2133MHz (Upgraded)
- <b>Screen</b>: 13.9-inch Full HD (1920 x 1080)
- <b>Trackpad</b>: ELAN (I2C)
- <b>Wi-Fi</b>: Broadcom DW1560 (BCM94352Z) Dual Band M.2 Ngff WiFi Card (Upgraded)
- <b>Ports</b>: 1 x USB-C, 2 x USB 3.0,USB 2.0 SD Card Reader, HDMI Display Port, Ethernet Port

# Overview 
This laptop is a budget laptop, by these specs, you can't do some heavy work, battery life is around 2-3 hours, It's good but not the best, if you want more you can choose higher specs, but consider that this guide may be different for your hardware.

# What's Working?
- Intel HD 620 Graphics full QE/CI 
- CPU power management 
- Battery (Cycles doesn't show properly)
- All USB ports 
- HDMI port (including HDMI Audio)
- Realtek Ethernet port 
- Realtek ALC230 Audio (including headphones jack)
- Wi-Fi & Bluetooth (including Apple services)
- Internal webcam with Facetime
- ELAN Trackpad with GPIO mode (including gestures)
- Sleep (lid sleep and lid wake)
- Screen Brightness with hotkeys

# What's Not Working?
- Apple Pay, requires TouchID, more information [here](https://discussions.apple.com/thread/7808558)
# Bugs
- DRM support (iTunes Movies, Apple TV+, Amazon Prime and Netflix, and others) could be fixed in the future, more information [here](https://github.com/acidanthera/bugtracker/issues/586) and [here](https://www.tonymacx86.com/threads/an-idiots-guide-to-lilu-and-its-plug-ins.260063/#DRM),

# Requirement 
- 8 GB USB Disk 
- macOS Catalina image downloaded from the Appstore 
- ~Mouse, because trackpad won't work in the installation~ Fixed with VoodooI2C v2.4

# BIOS Configuration
Before doing anything, remember to update your BIOS to the latest version from [here](https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/300-series/320-14ikb/downloads/ds121587), preparing your laptop to macOS, reboot your laptop, when the Lenovo logo's appear press <b>F2</b>, when the BIOS menu appears go to: 
- "Configuration" <b>SATA Controller Mode</b> to <b>AHCI</b>, <b>HotKey Mode</b> to <b>Enabled</b>.
- "Security" <b>Intel Platform Trust Technology</b> to <b>Disabled</b>, <b>Intel SGX</b> to <b>Disabled</b>, <b>Secure Boot</b> to <b>Disabled</b>.
- "Boot" <b>Boot Mode</b> to <b>UEFI</b>,<b>Fast Boot</b> to <b>Disabled</b>, <b>USB Boot</b> to <b>Enabled</b>.
- "Exit" <b>OS Optimized Defaults</b> to <b>Disabled</b>.

# Installation
After downloading macOS from the Appstore, format your USB drive as "Mac OS Extended (Journaled)", then open Terminal and type: `sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume`, and remember, `MyVolume` is for the name of your USB drive, you can change it if you would, mount the EFI partition in your USB, Copy-and-paste the folder `EFI` from this release's repository, download Clover Configurator from [here](https://mackie100projects.altervista.org/clover-configurator/), Then change the SMBIOS to MacBookPro14,1 which is the closest one to this laptop's hardware (copy it from Clover's config.plist to OpenCore's config.plist if youre using OpenCore), update your kexts and Clover Bootloader or OpenCore (if a new update is available), reboot your laptop and press `F12` to enter `BIOS Menu`, choose your USB installer and boot from it, you should see the `Clover Boot Menu`, boot from the USB that shown, it may take some time to boot, after is done, you should see `macOS Utilities`, choose `Disk Utility` and erase the drive you want to install macOS on it, click on `Erase` and type the name that you want, like: "Macintosh HD", choose the format as `APFS` and `Scheme` as `GUID Partition Map` and click `Erase`, after it's done, close the window and go back to `macOS Utilities` and choose `Install macOS`, click `Agree` to accept the license agreement, the installation should starts now, your laptop should restarts several times, after it's done, login to your AppleID (for more specific guide please go [here](https://dortania.github.io/oc-laptop-guide/)), after setting up your laptop, run `SleepFix.command`, type your password, this is gonna fix sleep for your laptop, unzip the folder `ALCPlugFix` and run `install.command`, type your password, this is gonna fix the static noise from your headphone after sleep, install Sniki's CodecCommander kext which can be found [here](https://github.com/Sniki/EAPD-Codec-Commander) to `/Library/Extensions` by running the command `KextInstall.command` 
Restart, and you're ready to go!

# Extras
- After you finished the installation you'll notice that your iMessage and other Apple services aren't working! to fix that issue you have to add `ROM`, `MLB` and a proper SMBIOS (which is MacBookPro14,1 for this device) in your `config.plist`, for more information follow this guide from [here](https://www.tonymacx86.com/threads/an-idiots-guide-to-imessage.196827/).
- If you have an SSD installed, you can enable TRIM support on it, just enable this option in your `config.plist` and enjoy! (consider that it may slow booting a bit for APFS formated SSDs, more information about TRIM [here](https://en.wikipedia.org/wiki/Trim_(computing))
Clover:
![](Images/TRIM.png)
OpenCore:
![](Images/TRIM-OC.png)
- If you don't like the name of your laptop that shown in "About This Mac", you can change it! Press Shift+Cmd+G <kbd>⇧⌘G</kbd> and copy-and-paste this path: `/Users/Username/Library/Preferences/com.apple.SystemProfiler.plist`, and remember, The word `Username` Is for your username, now download your favorite plist editor (mine is "PilstEdit Pro"), then you can change to `Lenovo IdeaPad 320-14IKB (80XK)` or any name you want.
![](Images/Edit.png)
![](Images/About_This_Mac.png)
- VoodooPS2Contoller recognize <kbd>Alt</kbd> key as <kbd>Cmd</kbd> and <kbd>Win</kbd> key as <kbd>Option</kbd> for some-reason, if you want to fix this issue use `SSDT-Swap-Cmd-Alt` in the ACPI folder(or swap them in `System Preferences` as shown in the photo), also, the key <kbd>PrtSc</kbd> can be remapped from disabling trackpad to take screenshots and record videos, use `SSDT-PrtSC-F13` for remapping it to <kbd>F13</kbd>, but if you want to use both of them, use `SSDT-PS2-Map`(not both of them to avoid Kernel Panic), if you don't want anything to change, you can delete it.
![](Images/Keyboard.png)
![](Images/Remap.png)
- Who needs CDs these days? You can buy this caddy and replace it with the CD Drive from [here](https://www.aliexpress.com/item/32850001303.html) to get dual drives.
- 4 GB of ram isn't enough these days, Unfortunately, 4 GB is built-in the motherboard, so the maximum is 12 GB, you can upgrade your RAM to 12 GB total from [here](https://www.amazon.com/Corsair-Module-2133MHz-Unbuffered-SODIMM/dp/B0143UM6Y0/ref=sr_1_6?dchild=1&keywords=8+ram+2133&qid=1585516185&s=electronics&sr=1-6).
- The Wi-Fi card that shipped with this laptop is Intel Wi-Fi card, there's a kext for it under development which can be found [here](https://github.com/AppleIntelWifi/adapter), but for now, you can buy the BCM94360CS2, an Apple wifi card for this laptop for less than 40$ (USD), nowadays, The DW1560 is quite expensive and it's not from Apple, fortunately, I bought it before it becomes, if you want to buy it instead of the DW1560, You can delete all Wi-Fi and Bluetooth kexts from the EFI folder because it's natively supported in macOS, [The Wi-Fi Card](https://www.aliexpress.com/item/32637520988.html?trace=wwwdetail2mobilesitedetail&spm=a2g0s.9042311.0.0.5e204c4dWDlWnx), [The Adapter](https://www.aliexpress.com/item/4000300306817.html?trace=wwwdetail2mobilesitedetail&trace=wwwdetail2mobilesitedetail&spm=a2g0s.9042311.0.0.5e204c4dWDlWnx), [The Antennas](https://www.aliexpress.com/item/32862630916.html?trace=wwwdetail2mobilesitedetail&spm=a2g0s.9042311.0.0.5e204c4dWDlWnx).
- You can change the frequency of your CPU in 'config.plist' as shown in the photo, without changing it, macOS will recognize it as 2.71 GHz for some-reason. 
![](Images/CPU.png)
- You can change the name of your graphics like this, I chose the name `Intel HD Graphics 620 macOS Edition` you can choose whatever you want as shown in the photo.
Clover:
![](Images/Graphics.png)
OpenCore:
![](Images/Graphics-OC.png)
- You can make your laptop boots automatic to macOS if you don't have another OS installed as shown in the photos, type your drive's name, check `Fast` and check `Auto=Yes`, now your laptop should boot automatically to macOS without the `Clover Boot Menu`.
![](Images/Auto1.png)
![](Images/Auto2.png)
- You can get the famous Mac-Chime when booting! By enabling these two options in your `config.plist` and copying `AudioDxe.efi` to `Drivers` folder you can get it, but consider that it may slow your booting a bit.
![](Images/Chime.png)
- If you want to get these options to choose the resolution like this you can! by running this command which can be found [here](https://github.com/xzhih/one-key-hidpi), type your password and choose the numbers 1,3,1 then restart.
![](Images/HiDPI.png)
- If you don't like the default Clover you can change it! Search the web and choose your favorite theme, copy-and-paste it to `themes` in `EFI` folder, then go to your `config.plist`, `GUI` section, `Theme` and type the name of your theme, you can use `Clover OSS Theme`, which looks like a real Mac boot-up screen. 
![](Images/Theme.png)

# Credits
- [Apple](https://www.apple.com) for macOS.
- [Acidanthera](https://github.com/acidanthera) for most of the kexts.
- [goodwin](https://github.com/goodwin) for ALCPlugFix.
- [RehabMan](https://github.com/RehabMan) for some patches.
- [Sniki](https://github.com/Sniki) for some patches.
- [daliansky](https://github.com/daliansky) for some patches.
- [Moh_Ameen](https://github.com/ameenjuz) for some patches.
- [al3xtjames](https://github.com/al3xtjames) for clover-theme-oss theme.
- [ImmersiveX](https://github.com/ImmersiveX) for clover-theme-minimal-dark theme.
- And anyone else that helped to develop and improve hackintoshing.
