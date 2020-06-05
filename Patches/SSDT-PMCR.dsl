// WARNING: this patch is only for Lenovo IdeaPad 320-14IKB
// May not work for your device.
// Add PMCR device for Lenovo IdeaPad 320-14IKB.

DefinitionBlock ("", "SSDT", 2, "Lenovo", "_PMCR", 0)
{
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
}
