// WARNING: this patch is only for Lenovo IdeaPad 320-14IKB
// May not work for your device.
// Lenovo IdeaPad 320 14-IKB complete patches for Clover and OpenCore Bootloaders.

DefinitionBlock ("", "SSDT", 2, "Lenovo", "_LIP", 0)
{
    External (_PR_.CPU0, ProcessorObj)
    External (_SB_.PCI0, DeviceObj)
    External (_SB_.PCI0.I2C0, DeviceObj)
    External (_SB_.PCI0.I2C0.TPD0, DeviceObj)
    External (_SB_.PCI0.I2C0.TPD0.SBFG, IntObj)
    External (_SB_.PCI0.I2C0.TPD0.SBFS, IntObj)
    External (_SB_.PCI0.LPCB.EC__, DeviceObj)
    External (_SB_.PCI0.LPCB.EC__.XQ1C, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.EC__.XQ1D, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.HPET, DeviceObj)
    External (_SB_.PCI0.LPCB.KBD0, DeviceObj)
    External (_SB_.PCI0.LPCB.PS2K, DeviceObj)
    External (_SB_.PCI0.SBUS, DeviceObj)
    External (_SB_.PCI0.XHC_.PMEE, FieldUnitObj)
    External (HPTE, FieldUnitObj)
    External (XPRW, MethodObj)    // 2 Arguments
    External (ZPTS, MethodObj)    // 1 Arguments

    Method (_PTS, 1, NotSerialized)  // Fix Auto Start after Shutdown if a USB device is plugged In
    {
        If (_OSI ("Darwin"))
        {
            If ((0x05 == Arg0))
            {
                \_SB.PCI0.XHC.PMEE = Zero
            }
        }

        ZPTS (Arg0)
    }

    Method (GPRW, 2, NotSerialized) // Solving instant wake by hooking GPRW or UPRW 
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

            Return (XPRW (Arg0, Arg1))
        }
        Else
        {
            Return (XPRW (Arg0, Arg1))
        }
    }

    Method (XOSI, 1, NotSerialized) // Override for host defined _OSI to handle "Darwin"
    {
        If (_OSI ("Darwin"))
        {
            If ((Arg0 == "Windows 2012"))
            {
                Return (0xFFFFFFFF)
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

    Scope (_PR.CPU0) // Enable power managment by injecting plugin-type=1
    {
        If (_OSI ("Darwin"))
        {
            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
            {
                If (!Arg2)
                {
                    Return (Buffer (One)
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

    Scope (_SB) // Add PNLF device, pair with WhateverGreen.kext and Lilu.kext
    {
        Device (PNLF)
        {
            Name (_HID, EisaId ("APP0002"))  // _HID: Hardware ID
            Name (_CID, "backlight")  // _CID: Compatible ID
            Name (_UID, 0x10)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }
    }
    
    Scope (_SB.PCI0)
    {
        Device (MCHC) // Add MCHC device
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
    
    Scope (_SB.PCI0.I2C0) // ELAN and Synaptics Trackpad Fix, pair with VoodooI2C.kext
    {
        If (_OSI ("Darwin"))
        {
            Return (0x0F)
        }
        Else
        {
            Return (Zero)
        }

        Name (SSCN, Package ()
        {
            0x01B0, 
            0x01FB, 
            0x1E
        })
        Name (FMCN, Package ()
        {
            0x48, 
            0xA0, 
            0x1E
        })
    }

    Scope (_SB.PCI0.I2C0.TPD0) // ELAN and Synaptics Trackpad Fix, pair with VoodooI2C.kext
    {
        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
        {
            If (_OSI ("Darwin")){}
            Return (ConcatenateResTemplate (SBFS, SBFG))
        }
    }
    
    Scope (_SB.PCI0.LPCB.EC) // Brightness Keyboard shortcut, pair with VoodooPS2Keyboard.kext (inside VoodooPS2Controller.kext)
    {
        Method (_Q1D, 0, NotSerialized) // (F11) Brightness Down
        {
            If (_OSI ("Darwin"))
            {
                Notify (KBD0, 0x0405)
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ1C ()
            }
        }

        Method (_Q1C, 0, NotSerialized)  // (F12) Brightness Up
        {
            If (_OSI ("Darwin"))
            {
                Notify (KBD0, 0x0406)
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ1D ()
            }
        }
    }

    Scope (_SB.PCI0.LPCB.HPET) // Disable HPET device
    {
        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            If (_OSI ("Darwin"))
            {
                HPTE = Zero
            }
        }
    }

    Scope (_SB.PCI0.LPCB.PS2K) // Keyboard remap PrtSc to F13 and swap Command to Win, pair with VoodooPS2Keyboard.kext (inside VoodooPS2Controller.kext)
    {
        If (_OSI ("Darwin"))
        {
            Name (RMCF, Package ()
            {
                "Keyboard", 
                Package ()
                {
                    "Custom PS2 Map", 
                    Package ()
                    {
                        Package (){}, 
                        "e037=64"
                    }, 

                    "Swap command and option", 
                    ">n"
                }
            })
        }
    }

    Scope (_SB.PCI0.SBUS) // Add BUS0 and BLC0 devices
    {
        Device (BUS0)
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
                        Return (Buffer (One)
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

    Device (_SB.USBX) // USB Ports Power, pair with USBPorts.kext
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

        Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
        {
            If (!Arg2)
            {
                Return (Buffer (One)
                {
                     0x03                                             
                })
            }

            Return (Package ()
            {
                "kUSBSleepPortCurrentLimit", 
                0x0BB8, 
                "kUSBWakePortCurrentLimit", 
                0x0BB8
            })
        }
    }

    Device (ALS0) // Add ambient light sensor device, pair with VirtualSMC.kext and SMCLightSensor.kext
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

    Device (DMAC) // Add DMAC device
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

    Device (MEM2) // Add MEM2 device
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

    Device (PMCR)
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
                Return (0x0B)
            }
            Else
            {
                Return (Zero)
            }
        }
    }

    Device (UIAC) // USB Ports Injector, pair with USBPorts.kext
    {
        Name (_HID, "UIA00000")  // _HID: Hardware ID
        Name (RMCF, Package ()
        {
            "8086_9d2f", 
            Package ()
            {
                "port-count", 
                Buffer ()
                {
                     0x15, 0x00, 0x00, 0x00
                }, 

                "ports", 
                Package ()
                {
                    "HS01", 
                    Package ()
                    {
                        "UsbConnector", 
                        0x03, 
                        "port", 
                        Buffer ()
                        {
                             0x01, 0x00, 0x00, 0x00
                        }
                    }, 

                    "HS02", 
                    Package ()
                    {
                        "UsbConnector", 
                        0x09, 
                        "port", 
                        Buffer ()
                        {
                             0x02, 0x00, 0x00, 0x00
                        }
                    }, 

                    "HS03", 
                    Package ()
                    {
                        "UsbConnector", 
                        0x03, 
                        "port", 
                        Buffer ()
                        {
                             0x03, 0x00, 0x00, 0x00                          
                        }
                    }, 

                    "HS04", 
                    Package ()
                    {
                        "UsbConnector", 
                        0xFF, 
                        "port", 
                        Buffer ()
                        {
                             0x04, 0x00, 0x00, 0x00
                        }
                    }, 

                    "HS05", 
                    Package ()
                    {
                        "UsbConnector", 
                        Zero, 
                        "port", 
                        Buffer ()
                        {
                             0x05, 0x00, 0x00, 0x00
                        }
                    }, 

                    "HS06", 
                    Package ()
                    {
                        "UsbConnector", 
                        0x03, 
                        "port", 
                        Buffer ()
                        {
                             0x06, 0x00, 0x00, 0x00
                        }
                    }, 

                    "HS07", 
                    Package ()
                    {
                        "UsbConnector", 
                        0xFF, 
                        "port", 
                        Buffer ()
                        {
                             0x07, 0x00, 0x00, 0x00
                        }
                    }, 

                    "HS08", 
                    Package ()
                    {
                        "UsbConnector", 
                        0xFF, 
                        "port", 
                        Buffer ()
                        {
                             0x08, 0x00, 0x00, 0x00
                        }
                    }, 

                    "HS09", 
                    Package ()
                    {
                        "UsbConnector", 
                        0x03, 
                        "port", 
                        Buffer ()
                        {
                             0x09, 0x00, 0x00, 0x00
                        }
                    }, 

                    "HS10", 
                    Package ()
                    {
                        "UsbConnector", 
                        0x03, 
                        "port", 
                        Buffer ()
                        {
                             0x0A, 0x00, 0x00, 0x00
                        }
                    }, 

                    "SS01", 
                    Package ()
                    {
                        "UsbConnector", 
                        0x03, 
                        "port", 
                        Buffer ()
                        {
                             0x0B, 0x00, 0x00, 0x00
                        }
                    }, 

                    "SS02", 
                    Package ()
                    {
                        "UsbConnector", 
                        0x09, 
                        "port", 
                        Buffer ()
                        {
                             0x0C, 0x00, 0x00, 0x00
                        }
                    }, 

                    "SS03", 
                    Package ()
                    {
                        "UsbConnector", 
                        0x03, 
                        "port", 
                        Buffer ()
                        {
                             0x0D, 0x00, 0x00, 0x00
                        }
                    }, 

                    "USR1", 
                    Package ()
                    {
                        "UsbConnector", 
                        0x03, 
                        "port", 
                        Buffer (0x04)
                        {
                             0x0E, 0x00, 0x00, 0x00
                        }
                    }, 

                    "USR2", 
                    Package ()
                    {
                        "UsbConnector", 
                        0x03, 
                        "port", 
                        Buffer ()
                        {
                             0x0F, 0x00, 0x00, 0x00
                        }
                    }
                }
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
}

