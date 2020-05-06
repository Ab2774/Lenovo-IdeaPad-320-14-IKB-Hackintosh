# Lenovo-IdeaPad 320-14IKB Hackintosh Changelog

# EFI v1.0.0
- First release!


# EFI v1.1.0
- Updated Clover version to `5109`
- Updated  `AppleALC`  to `1.4.8`
- Updated `BrcmPatchRAM`  to `2.5.2`
- Updated `Lilu`  to `1.4.3`
- Updated `VirtualSMC`  and Plug-ins to `1.1.2`
- Updated `VoodooPS2Controller`  to `2.1.3`
- Updated `WhateverGreen`  to `1.3.8`
- Updated `USBPorts`
- Updated `SSDT-GPRW`
- Updated `SSDT-I2C`
- Updated `SSDT-PTS`
- Updated `SSDT-USB`
- Updated `SSDT-XOSI`
- Added `change ECWK to XCWK` patch in `config.plist`
- Added `FixSBUS` and `AddMCHC` fixes in `config.plist`
- Added `xh_rvp07 `and `xh_rvp10 `SSDT in `config.plist`
- Added  `dart=0` boot-arg in `config.plist` for better sleep
- Added `Inject` in `USB` in `config.plist` for better USB injection
- Added `enable-hdmi20` and `enable-lspcon-support` in `config.plist` for better graphics
- Added `PanicNoKextDump` in `config.plist`
- Added `Trust` in `SMBIOS` in  `config.plist`
- Added `SSDT-DMAC`, `SSDT-MEM2`, `SSDT-PMCR`, `SSDT-HPET`, `SSDT-Swap-Cmd-Alt` and `SSDT-ALS0` to be more like a real Mac
- Added `SSDT-PS2K` for swapping Cmd and Alt and remap PrtSc to F13 together 
- Added `SSDT-KBD` instead of `SSDT-PS2K` for brightness keys
- Added better clover theme `clover-theme-oss`
- Removed `CodecCommander` from  `/Volumes/EFI/EFI/CLOVER/kexts/Other`  to  `/Library/Extensions`
- Removed `HDAS to HDEF` and `HECI to IMEI` patch in `config.plist` becuase it's no longer needed
- Removed `change TPD0._DSM to XDSM` patch in `config.plist` becuase it's no longer needed
- Removed `change Notify (BAT0, 0x81 to BATC)` and  `change Notify (BAT0, 0x80 to BATC)` patch in `config.plist` becuase it's no longer needed
- Removed `AddPNLF` in `config.plist` And replaced  with  `SSDT-PNLF` and `SSDT-ALSO` and for better brightness 
- Removed `FixRegion` in `config.plist` becuase it's no longer needed
- Removed  `NoOemTabeld` and  `NoDynamicExtract` SSDT in `config.plist` because it's no longer needed
- Removed `Halt Enabler` and `FixHeaders` in `config.plist` because it's no longer needed
- Removed `RtcHibernateAware` and `SkipHibernateTimeout` and replace with `NeverHibernate` for better sleep and power management 
- Removed `Add ClockID` in `USB` in `config.plist` because it's no longer needed
- Removed `Kernel LAPIC` in `Kernel and Kexts Patches` in `config.plist` because it's no longer needed
- Removed `Prevent Apple I2C kexts from attaching to I2C controllers` patches because it's no longer needed
- Removed `MSR 0xE2 _xcpm_idle instant reboot` because it's no longer needed
- Removed `Memory` info in `SMBIOS` in `config.plist` becuase not all people have the same branded RAM
- Removed `SMCSuperIO.kext` because it failed to detect SuperIO chip
- Removed `SSDT-USB_kextless` because it's no longer needed
- Removed `SSDT-EC` because it's no longer needed
- Removed `SSDT-RMCF` because it's no longer needed
- Support Catalina 10.15.4


# EFI v1.1.1
- Updated Clover version to `5115`
- Updated `AirportBrcmFixup` to `2.0.7`
- Updated  `AppleALC`  to `1.4.9`
- Updated `BrcmPatchRAM`  to `2.5.3`
- Updated `Lilu`  to `1.4.4`
- Updated `VirtualSMC`  and Plug-ins to `1.1.3`
- Updated `VoodooPS2Controller`  to `2.1.4`
- Updated `VoodooI2C` and satellites  to `2.4.1`
- Updated `WhateverGreen`  to `1.3.9`
- Updated `SSDT-ALS0`
- Updated `SSDT-I2C`
- Updated `SSDT-KBD` 
- Updated `SSDT-PNLF` 
- Updated `SSDT-PS2K` and renamed  as `SSDT-PS2-Map` 
- Updated `SSDT-PrtSc-F13` 
- Updated `SSDT-XOSI`
- Updated `SSDT-Swap-Cmd-Alt`  
- Updated `SSDT-PrtSc-13` to support both `Clover` and `OpenCore` Bootloaders  
- Updated `SSDT-PTS` and `SSDT-XOSI` to support both `Clover` and `OpenCore` Bootloaders
- Updated `layout-id` property in `config.plist` 
- Updated `HFSPlus` driver for `Clover` Bootloader
- Updated `clover-theme-oss` icons with high quality ones and fixed font
- Added `OpenCore` Bootloader!
- Added `NTFS` driver for `Clover` Bootloader
- Added `device-id` property in `config.plist` for `Audio` device
- Added `Enable TRIM for SSD` in `KextToPatch` in  `config.plist`
- Added `SSDT-LIP320-14IKB` combining all the patches in one `SSDT` for `Clover` and `OpenCore` Bootloaders
- Added `SSDT-PLUG`, `SSDT-SBUS` and `SSDT-MCHC` to support `OpenCore` Bootloader
- Removed `change GFX0 to IGPU`,  `change TPD0._DSM to XDSM` and `change ECWK to XCWK` patches in `config.plist` becuase they are no longer needed
- Removed `AddMCHC` in `config.plist` and replaced with `SSDT-MCHC` for `OpenCore` compatibility 
- Removed `FixSBUS` in `config.plist` and replaced with `SSDT-SBUS` for `OpenCore` compatibility 
- Removed `VoodooI2CHID.kext` because it's no longer needed
