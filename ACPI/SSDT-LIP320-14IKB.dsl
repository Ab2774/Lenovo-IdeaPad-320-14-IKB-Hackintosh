// WARNING: this patch is only for Lenovo IdeaPad 320-14IKB
// May not work for your device
// Guide: https://github.com/Ab2774/Lenovo-IdeaPad-320-14-IKB-Hackintosh
// Complete patches for Lenovo IdeaPad 320-14IKB

DefinitionBlock ("", "SSDT", 2, "Lenovo", "_LIP", 0)
{
    External (_PR_.CPU0, ProcessorObj)
    External (_SB_.PCI0, DeviceObj)
    External (_SB_.PCI0.GPI0, DeviceObj)
    External (_SB_.PCI0.I2C0.TPD0, DeviceObj)
    External (_SB_.PCI0.I2C0.TPD0.SBFG, IntObj)
    External (_SB_.PCI0.I2C0.TPD0.SBFS, IntObj)
    External (_SB_.PCI0.LPCB.PS2K, DeviceObj)
    External (_SB_.PCI0.LPCB.RTC_, DeviceObj)
    External (_SB_.PCI0.LPCB.TIMR, DeviceObj)
    External (_SB_.PCI0.SBUS, DeviceObj)
    External (_SB_.PCI0.XHC_.PMEE, FieldUnitObj)
    External (HPTE, IntObj)
    External (XPRW, MethodObj)    // 2 Arguments
    External (ZPTS, MethodObj)    // 1 Arguments

    Method (_PTS, 1, NotSerialized)  // _PTS: Prepare To Sleep
    {
        If (_OSI ("Darwin"))
        {
            If ((0x05 == Arg0))
            {
                \_SB.PCI0.XHC.PMEE = Zero  // Fix auto start after Shut Down if an USB device is plugged in, pair with _PTS to ZPTS Rename Method
            }
        }

        ZPTS (Arg0)
    }

    Method (GPRW, 2, NotSerialized)  // Fix instant wake by hooking GPRW, pair with GPRW to XPRW Rename Method
    {
        If (_OSI ("Darwin"))
        {
            If ((0x6D == Arg0))
            {
                Return (Package ()
                {
                    0x6D, 
                    Zero
                })
            }

            If ((0x0D == Arg0))
            {
                Return (Package ()
                {
                    0x0D, 
                    Zero
                })
            }
        }

        Return (XPRW (Arg0, Arg1))
    }

    Method (XOSI, 1, NotSerialized)  // Override for host defined _OSI to handle "Darwin", pair with _OSI to XOSI Rename Method
    {
        If (_OSI ("Darwin"))
        {
            If ((Arg0 == "Windows 2012"))
            {
                Return (0x0F)
            }
            Else
            {
                Return (Zero)
            }

            If ((Arg0 == "Windows 2015"))
            {
                Return (0x0F)
            }
            Else
            {
                Return (Zero)
            }
        }
        Else
        {
            Return (_OSI (Arg0))
        }
    }

    Scope (_PR.CPU0)  // Enable Power Managment by injecting PluginType=1
    {
        If (_OSI ("Darwin"))
        {
            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
            {
                If (!Arg2)
                {
                    Return (Buffer ()
                    {
                         0x03                                             
                    })
                }

                Return (Package ()
                {
                    "plugin-type", 
                    One
                })
            }
        }
    }

    Scope (_SB)
    {
        Device (PNLF)  // Add PNLF device, pair with WhateverGreen and Lilu kexts
        {
            Name (_HID, EisaId ("APP0002"))  // _HID: Hardware ID
            Name (_CID, "backlight")  // _CID: Compatible ID
            Name (_UID, 0x10)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }

        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            If (_OSI ("Darwin"))
            {
                HPTE = Zero  // Disable High Precision Event Timer (HPET) device
            }
        }
    }

    Scope (_SB.PCI0)
    {
        Device (MCHC)  // Add MCHC device
        {
            Name (_ADR, Zero)  // _ADR: Address
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }
    }
    
    Scope (_SB.PCI0.GPI0)  // Enable ELAN and Synaptics Trackpad
    {
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }
            Else
            {
                Return (Zero)
            }
        }
    }
    
    Scope (_SB.PCI0.I2C0.TPD0)  // Enable ELAN and Synaptics Trackpad, pair with VoodooI2C kext
    {
        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
        {
            If (_OSI ("Darwin"))
            {
                Return (ConcatenateResTemplate (SBFS, SBFG))
            }
            Else
            {
                Return (Buffer (Zero){})
            }
        }
    }
    
    Scope (_SB.PCI0.LPCB.RTC)  // Disable Real Time Clock (RTC) device
    {
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (Zero)
            }
            Else
            {
                Return (0x0F)
            }
        }
    }
    
    Scope (_SB.PCI0.LPCB.TIMR)  // Disable TIMR device
    {
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (Zero)
            }
            Else
            {
                Return (0x0F)
            }
        }
    }

    Scope (_SB.PCI0.LPCB.PS2K)  // Pair with VoodooPS2Keyboard kext (inside VoodooPS2Controller kext)
    {
        If (_OSI ("Darwin"))
        {
            Name (RMCF, Package ()
            {
                "Keyboard", 
                Package ()
                {
                    "Breakless PS2", 
                    Package ()
                    {
                        Package (){}, 
                        "e06a",
                        "e06b"
                    }, 

                    "Macro Inversion", 
                    Package ()
                    {
                        Buffer ()
                        {
                            0xFF, 0xFF, 0x02, 0x6A, 0x00, 0x00,
                            0x00, 0x00, 0x02, 0x5B, 0x01, 0x26
                        }, 

                        Buffer ()
                        {
                            0xFF, 0xFF, 0x02, 0xEA, 0x00, 0x00,
                            0x00, 0x00, 0x01, 0x99, 0x02, 0xDB
                        }, 

                        Buffer ()
                        {
                            0xFF, 0xFF, 0x02, 0x6B, 0x00, 0x00,
                            0x00, 0x00, 0x02, 0x5B, 0x01, 0x19
                        }, 

                        Buffer ()
                        {
                            0xFF, 0xFF, 0x02, 0xEB, 0x00, 0x00,
                            0x00, 0x00, 0x01, 0x99, 0x02, 0xDB
                        }
                    }, 

                    "Custom ADB Map", 
                    Package ()
                    {
                        Package (){}, 
                        "3b=4a",  // (F1) Volume Mute
                        "3c=49",  // (F2) Volume Down
                        "3d=48",  // (F3) Volume Up
                        "e06a=65",  // F9
                        "e06b=6d",  // F10
                        "57=6b",  // F11=14
                        "58=71"  // F12=F15
                    }, 

                    "Custom PS2 Map", 
                    Package ()
                    {
                        Package (){}, 
                        "e037=64",  // PrtSc=F13
                        "40=e037",  // F9=PrtSc (Disable Trackpad)
                        "e053=0e",  // Delete=Backspace
                        "46=2e",  // Fn+C=C
                        "e045=19"  // Fn+P=P
                    }, 

                     "RemapPrntScr",  // Enable PrtSc
                    ">y", 
                    "Swap command and option",  // Command to Win
                    ">n"
                }
            })
        }
    }

    Scope (_SB.PCI0.SBUS)
    {
        Device (BUS0)  // Add counterfeit BUS0 and BLC0 devices
        {
            Name (_CID, "smbus")  // _CID: Compatible ID
            Name (_ADR, Zero)  // _ADR: Address
            Device (BLC0)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_CID, "smbus-blc")  // _CID: Compatible ID
                Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                {
                    If ((Arg2 == Zero))
                    {
                        Return (Buffer ()
                        {
                             0x03                                             
                        })
                    }

                    Return (Package ()
                    {
                        "refnum", 
                        Zero, 
                        "address", 
                        0x2C, 
                        "command", 
                        Zero, 
                        "type", 
                        0x49324300, 
                        "version", 
                        0x02, 
                        "fault-off", 
                        0x03, 
                        "fault-len", 
                        0x04, 
                        "skey", 
                        0x4C445342, 
                        "smask", 
                        0xFF
                    })
                }
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }
    }

    Device (ALS0)  // Add counterfeit Ambient Light Sensor (ALS0) device, pair with VirtualSMC and SMCLightSensor kexts
    {
        Name (_HID, "ACPI0008" /* Ambient Light Sensor Device */)  // _HID: Hardware ID
        Name (_CID, "smc-als")  // _CID: Compatible ID
        Name (_ALI, 0x012C)  // _ALI: Ambient Light Illuminance
        Name (_ALR, Package ()  // _ALR: Ambient Light Response
        {
            Package ()
            {
                0x64, 
                0x012C
            }
        })
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }
            Else
            {
                Return (Zero)
            }
        }
    }

    Device (DMAC)  // Add Direct Memory Access Control (DMAC) device
    {
        Name (_HID, EisaId ("PNP0200") /* PC-class DMA Controller */)  // _HID: Hardware ID
        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            IO (Decode16,
                0x0000,             // Range Minimum
                0x0000,             // Range Maximum
                0x01,               // Alignment
                0x20,               // Length
                )
            IO (Decode16,
                0x0081,             // Range Minimum
                0x0081,             // Range Maximum
                0x01,               // Alignment
                0x11,               // Length
                )
            IO (Decode16,
                0x0093,             // Range Minimum
                0x0093,             // Range Maximum
                0x01,               // Alignment
                0x0D,               // Length
                )
            IO (Decode16,
                0x00C0,             // Range Minimum
                0x00C0,             // Range Maximum
                0x01,               // Alignment
                0x20,               // Length
                )
            DMA (Compatibility, NotBusMaster, Transfer8_16, )
                {4}
        })
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }
            Else
            {
                Return (Zero)
            }
        }
    }

    Device (EC)  // Add counterfeit Embedded Controller (EC) device
    {
        Name (_HID, "EC000000")  // _HID: Hardware ID
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }
            Else
            {
                Return (Zero)
            }
        }
    }
    
    Device (HPE0)  // Add counterfeit High Precision Event Timer (HPE0) device
    {
        Name (_HID, EisaId ("PNP0103") /* HPET System Timer */)  // _HID: Hardware ID
        Name (_UID, Zero)  // _UID: Unique ID
        Name (BUF0, ResourceTemplate ()
        {
            IRQNoFlags ()
                {0,8}
            Memory32Fixed (ReadWrite,
                0xFED00000,         // Address Base
                0x00000400,         // Address Length
                )
        })
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }
            Else
            {
                Return (Zero)
            }
        }

        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
        {
            Return (BUF0) /* \HPE0.BUF0 */
        }
    }

    Device (MEM2)  // Add MEM2 device
    {
        Name (_HID, EisaId ("PNP0C01") /* System Board */)  // _HID: Hardware ID
        Name (_UID, 0x02)  // _UID: Unique ID
        Name (CRS, ResourceTemplate ()
        {
            Memory32Fixed (ReadWrite,
                0x20000000,         // Address Base
                0x00200000,         // Address Length
                )
            Memory32Fixed (ReadWrite,
                0x40000000,         // Address Base
                0x00200000,         // Address Length
                )
        })
        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
        {
            Return (CRS) /* \MEM2.CRS_ */
        }

        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }
            Else
            {
                Return (Zero)
            }
        }
    }

    Device (PMCR)  // Add Power Management Capabilities Register (PMCR) device
    {
        Name (_HID, EisaId ("APP9876"))  // _HID: Hardware ID
        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            Memory32Fixed (ReadWrite,
                0xFE000000,         // Address Base
                0x00010000,         // Address Length
                )
        })
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }
            Else
            {
                Return (Zero)
            }
        }
    }

    Device (RHUB)  // USB Ports Injector
    {
        Name (_HID, "RHUB0000")  // _HID: Hardware ID
        Device (HS01)  // USB 3.0 First
        {
            Name (_ADR, One)  // _ADR: Address
            Name (_UPC, Package ()  // _UPC: USB Port Capabilities
            {
                0xFF, 
                0x03, 
                Zero, 
                Zero
            })
        }

        Device (HS02)  // USB-C With Switch
        {
            Name (_ADR, 0x02)  // _ADR: Address
            Name (_UPC, Package ()  // _UPC: USB Port Capabilities
            {
                0xFF, 
                0x09, 
                Zero, 
                Zero
            })
        }

        Device (HS03)  // USB 3.0 Second
        {
            Name (_ADR, 0x03)  // _ADR: Address
            Name (_UPC, Package ()  // _UPC: USB Port Capabilities
            {
                0xFF, 
                0x03, 
                Zero, 
                Zero
            })
        }

        Device (HS04)
        {
            Name (_ADR, 0x04)  // _ADR: Address
            Name (_UPC, Package ()  // _UPC: USB Port Capabilities
            {
                0xFF, 
                0xFF, 
                Zero, 
                Zero
            })
        }

        Device (HS05)  // USB 2.0 SD Card Reader
        {
            Name (_ADR, 0x05)  // _ADR: Address
            Name (_UPC, Package ()  // _UPC: USB Port Capabilities
            {
                0xFF, 
                0xFF, 
                Zero, 
                Zero
            })
        }

        Device (HS07)  // Bluetooth Card
        {
            Name (_ADR, 0x07)  // _ADR: Address
            Name (_UPC, Package ()  // _UPC: USB Port Capabilities
            {
                0xFF, 
                0xFF, 
                Zero, 
                Zero
            })
        }

        Device (HS08)  // Integrated Camera
        {
            Name (_ADR, 0x08)  // _ADR: Address
            Name (_UPC, Package ()  // _UPC: USB Port Capabilities
            {
                0xFF, 
                0xFF, 
                Zero, 
                Zero
            })
        }

        Device (SS01)  // USB 3.0 First
        {
            Name (_ADR, 0x0D)  // _ADR: Address
            Name (_UPC, Package ()  // _UPC: USB Port Capabilities
            {
                0xFF, 
                0x03, 
                Zero, 
                Zero
            })
        }

        Device (SS02)
        {
            Name (_ADR, 0x0E)  // _ADR: Address
            Name (_UPC, Package ()  // _UPC: USB Port Capabilities
            {
                0xFF, 
                0x09, 
                Zero, 
                Zero
            })
        }

        Device (SS03)  // USB 3.0 Second
        {
            Name (_ADR, 0x0F)  // _ADR: Address
            Name (_UPC, Package ()  // _UPC: USB Port Capabilities
            {
                0xFF, 
                0x03, 
                Zero, 
                Zero
            })
        }

        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }
            Else
            {
                Return (Zero)
            }
        }
    }
    
    Device (RTC0)  // Add counterfeit Real Time Clock (RTC0) device
    {
        Name (_HID, EisaId ("PNP0B00") /* AT Real-Time Clock */)  // _HID: Hardware ID
        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            IO (Decode16,
                0x0070,             // Range Minimum
                0x0070,             // Range Maximum
                0x01,               // Alignment
                0x02,               // Length
                )
        })
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }
            Else
            {
                Return (Zero)
            }
        }
    }
    
    Device (TIM0)  // Add counterfeit TIM0 device
    {
        Name (_HID, EisaId ("PNP0100") /* PC-class System Timer */)  // _HID: Hardware ID
        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            IO (Decode16,
                0x0040,             // Range Minimum
                0x0040,             // Range Maximum
                0x01,               // Alignment
                0x04,               // Length
                )
            IO (Decode16,
                0x0050,             // Range Minimum
                0x0050,             // Range Maximum
                0x10,               // Alignment
                0x04,               // Length
                )
        })
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }
            Else
            {
                Return (Zero)
            }
        }
    }

    Device (USBX)  // USB Ports Power
    {
        Name (_ADR, Zero)  // _ADR: Address
        Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
        {
            If ((Arg2 == Zero))
            {
                Return (Buffer ()
                {
                     0x03
                })
            }

            Return (Package ()
            {
                "kUSBSleepPowerSupply", 
                0x13EC, 
                "kUSBSleepPortCurrentLimit", 
                0x0834, 
                "kUSBWakePowerSupply", 
                0x13EC, 
                "kUSBWakePortCurrentLimit", 
                0x0834
            })
        }

        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }
            Else
            {
                Return (Zero)
            }
        }
    }
}

