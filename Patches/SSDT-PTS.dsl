// WARNING: this patch is only for Lenovo IdeaPad 320-14IKB
// May not work for your device.
// Fix Auto Start after Shutdown if a USB device is plugged In.

DefinitionBlock ("", "SSDT", 2, "Lenovo", "_PTS", 0)
{
    External (_SB.PCI0.XHC.PMEE, FieldUnitObj)
    External (ZPTS, MethodObj)
    
    Method (_PTS, 1, NotSerialized)
    {
        If (_OSI ("Darwin"))
        {
            If (0x05 == Arg0)
            {
                \_SB.PCI0.XHC.PMEE = 0
            }
        }
        ZPTS (Arg0)
    }
}
