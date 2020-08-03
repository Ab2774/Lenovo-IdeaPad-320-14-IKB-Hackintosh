// WARNING: this patch is only for Lenovo IdeaPad 320-14IKB
// May not work for your device
// Guide: https://github.com/Ab2774/Lenovo-IdeaPad-320-14-IKB-Hackintosh
// Fix auto start after Shut Down if an USB device is plugged in
// Pair with _PTS to ZPTS Rename Method

DefinitionBlock ("", "SSDT", 2, "Lenovo", "_PTS", 0)
{
    External (_SB.PCI0.XHC.PMEE, FieldUnitObj)
    External (ZPTS, MethodObj)    // 1 Arguments
    
    Method (_PTS, 1, NotSerialized)  // _PTS: Prepare To Sleep
    {
        If (_OSI ("Darwin"))
        {
            If (0x05 == Arg0)
            {
                \_SB.PCI0.XHC.PMEE = Zero
            }
        }

        ZPTS (Arg0)
    }
}

