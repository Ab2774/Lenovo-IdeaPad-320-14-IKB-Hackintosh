// WARNING: this patch is only for Lenovo IdeaPad 320-14IKB
// May not work for your device
// Guide: https://github.com/Ab2774/Lenovo-IdeaPad-320-14-IKB-Hackintosh
// USB Ports Injector and USB Ports Power

DefinitionBlock ("", "SSDT", 2, "Lenovo", "_USB", 0)
{
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

