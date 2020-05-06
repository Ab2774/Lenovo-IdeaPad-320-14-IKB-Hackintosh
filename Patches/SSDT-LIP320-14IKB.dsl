// WARNING: this patch is only for Lenovo IdeaPad 320-14IKB
// May not work for your device.
// Lenovo IdeaPad 320 14-IKB complete patches for Clover and OpenCore Bootloaders.

DefinitionBlock ("", "SSDT", 2, "Lenovo", "_LIP", 0)
{
    External (_SB_.PCI0.SBUS, DeviceObj)
    External (_SB_.PCI0.I2C0, DeviceObj)    // (from opcode)
    External (_SB_.PCI0.I2C0.TPD0, DeviceObj)    // (from opcode)
    External (_SB_.PCI0.I2C0.TPD0.SBFB, UnknownObj)    // (from opcode)
    External (_SB_.PCI0.I2C0.TPD0.SBFG, UnknownObj)    // (from opcode)
    External (_SB_.PCI0.LPCB, DeviceObj)    // (from opcode)
    External (_SB_.PCI0.LPCB.EC, DeviceObj)    // (from opcode)
    External (_SB_.PCI0.LPCB.HPET, DeviceObj)    // (from opcode)
    External (_SB_.PCI0.LPCB.PS2K, DeviceObj)    // (from opcode)
    External (_SB_.PCI0.XHC_.PMEE, FieldUnitObj)    // (from opcode)
    External (_SB_.USBX, DeviceObj)    // (from opcode)
    External (_PR_.CPU0, ProcessorObj)
    External (HPTE, FieldUnitObj)    // (from opcode)
    External (XPRW, MethodObj)    // 2 Arguments (from opcode)
    External (ZPTS, MethodObj)    // 1 Arguments (from opcode)

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
    
    Method (_PTS, 1, NotSerialized)  // Fix Auto Start after Shutdown if a USB device is plugged In
    {
        If (_OSI ("Darwin"))
        {
            If (LEqual (0x05, Arg0))
            {
                Store (Zero, \_SB.PCI0.XHC.PMEE)
            }
        }

        ZPTS (Arg0)
    }
    Scope (_PR.CPU0) // Power Management patch
    {
        Method (DTGP, 5, NotSerialized)
        {
            If ((Arg0 == ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b")))
            {
                If ((Arg1 == One))
                {
                    If ((Arg2 == Zero))
                    {
                        Arg4 = Buffer (One)
                            {
                                 0x03                                            
                            }
                        Return (One)
                    }

                    If ((Arg2 == One))
                    {
                        Return (One)
                    }
                }
            }

            Arg4 = Buffer (One)
                {
                     0x00                                           
                }
            Return (Zero)
        }

        Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
        {
            Local0 = Package (0x02)
                {
                    "plugin-type", 
                    One
                }
            DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
            Return (Local0)
        }
    }
    
    Scope (_SB) // Add PNLF device 
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
    Scope (_SB.PCI0.SBUS) // Add BUS0 and DVL0 devices
    {
        Device (BUS0)
        {
            Name (_CID, "smbus")  // _CID: Compatible ID
            Name (_ADR, Zero)  // _ADR: Address
            Device (DVL0)
            {
                Name (_ADR, 0x57)  // _ADR: Address
                Name (_CID, "diagsvault")  // _CID: Compatible ID
                Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                {
                    If (!Arg2)
                    {
                        Return (Buffer (One)
                        {
                             0x03                                             
                        })
                    }

                    Return (Package (0x02)
                    {
                        "address", 
                        0x57
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

    Scope (_SB.PCI0.LPCB) 
    {
        Device (ALS0) // // Fake ambient light sensor device
        {
            Name (_HID, "ACPI0008" /* Ambient Light Sensor Device */)  // _HID: Hardware ID
            Name (_CID, "smc-als")  // _CID: Compatible ID
            Name (_ALI, 0x012C)  // _ALI: Ambient Light Illuminance
            Name (_ALR, Package (0x01)  // _ALR: Ambient Light Response
            {
                Package (0x02)
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

        Device (PMCR) // Add PMCR device
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
    }

    Scope (_SB.PCI0.LPCB.HPET) // Disable HPET device for Lenovo IdeaPad 320 14-IKB
    {
        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            If (_OSI ("Darwin"))
            {
                Store (Zero, HPTE)
            }
        }
    }

    

    Scope (_SB.PCI0.I2C0.TPD0) // Elan Trackpad Fix
    {
        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
        {
            If (_OSI ("Darwin")){}
            Return (ConcatenateResTemplate (SBFB, SBFG))
        }
    }
     Scope (_SB.PCI0.I2C0) // // Elan Trackpad Fix
    {
        If (_OSI ("Darwin"))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
        } 
                
        Name (SSCN, Package (0x03)
        {
            0x01B0, 
            0x01FB, 
            0x1E
        })
        Name (FMCN, Package (0x03)
        {
            0x48, 
            0xA0, 
            0x1E
        })
    }

    Scope (_SB.PCI0.LPCB.EC)
    {
        Device (DMAC) // Add DMAC device
        {
            Name (_HID, EisaId ("PNP0200"))  // _HID: Hardware ID
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

        Method (GPRW, 2, NotSerialized) // Solving instant wake by hooking GPRW or UPRW
        {
            If (_OSI ("Darwin"))
            {
                If (LEqual (0x6D, Arg0))
                {
                    Return (Package (0x02)
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
    }
    
    
    Scope (_SB.PCI0.LPCB.PS2K) // Keyboard remap PrtSc to F13 and swap Command to Win
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
                        "e037=64" // PrtSc=F13
                }, 
                
                "Swap command and option", // Command to Win; otherwise, Command to Alt
                ">n"
                    }
                }
            )
        }
    }
    

    Device (UIAC) // USB Ports Injector 
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
                    "HS01", // USB 3.0 First
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

                    "HS02", // USB 3.0 
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
                    
                     "HS03", // USB 3.0 Second
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

                    "HS05", // SD Card Reader
                    Package ()
                    {
                        "UsbConnector", 
                        0x00, 
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
                    
                    "HS07", // Integrated Camera
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
                    
                     "HS08", // Bluetooth
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
                        Buffer ()
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

    Device (MEM2) // Add MEM2 device
    {
        Name (_HID, EisaId ("PNP0C01"))  // _HID: Hardware ID
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
            Return (CRS)
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

    Device (_SB.USBX) // USB Ports Power
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
            If (LNot (Arg2))
            {
                Return (Buffer (One)
                {
                     0x03                                           
                })
            }

            Return (Package (0x04)
            {
                "kUSBSleepPortCurrentLimit", 
                0x0BB8, 
                "kUSBWakePortCurrentLimit", 
                0x0BB8
            })
        }
    }
}

