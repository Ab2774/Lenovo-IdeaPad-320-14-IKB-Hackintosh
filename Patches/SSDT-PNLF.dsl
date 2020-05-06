// WARNING: this patch is only for Lenovo IdeaPad 320-14IKB
// May not work for your device.
// Add PNLF device for Lenovo IdeaPad 320-14IKB.

DefinitionBlock ("", "SSDT", 2, "Lenovo", "_PNLF", 0x00000000)
{
    Scope (_SB)
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
}

