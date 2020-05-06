// WARNING: this patch is only for Lenovo IdeaPad 320-14IKB
// May not work for your device.
// Add MCHC device for Lenovo IdeaPad 320-14IKB.

DefinitionBlock ("", "SSDT", 2, "Lenovo", "_MCHC", 0)
{
    External (_SB_.PCI0, DeviceObj)

    Scope (_SB.PCI0)
    {
        Device (MCHC)
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
}

