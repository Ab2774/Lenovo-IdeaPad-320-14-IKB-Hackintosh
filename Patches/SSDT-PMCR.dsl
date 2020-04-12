// WARNING: this patch is only for Lenovo IdeaPad 320-14IKB
// May not work for your device.
// Add PMCR device for Lenovo IdeaPad 320-14IKB.

DefinitionBlock ("", "SSDT", 2, "V330", "_PMCR", 0)
{
    External(_SB.PCI0.LPCB, DeviceObj)
    Scope (_SB.PCI0.LPCB)
    {
        Device (PMCR)
        {
            Name (_HID, EisaId ("APP9876"))
            Name (_CRS, ResourceTemplate ()
            {
                Memory32Fixed (ReadWrite,
                    0xFE000000,
                    0x00010000 
                    )

            })
            Method (_STA, 0, NotSerialized)
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
}
