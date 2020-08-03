// WARNING: this patch is only for Lenovo IdeaPad 320-14IKB
// May not work for your device
// Guide: https://github.com/Ab2774/Lenovo-IdeaPad-320-14-IKB-Hackintosh
// Add counterfeit BUS0 and BLC0 devices

DefinitionBlock ("", "SSDT", 2, "Lenovo", "_SBUS", 0)
{
    External (_SB_.PCI0.SBUS, DeviceObj)

    Scope (_SB.PCI0.SBUS)
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
}

