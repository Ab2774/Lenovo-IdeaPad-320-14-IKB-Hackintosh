// WARNING: this patch is only for Lenovo IdeaPad 320-14IKB
// May not work for your device.
// Lenovo IdeaPad 320 14-IKB keyboard remap by swapping Command to Win.
// Pair with VoodooPS2Keyboard.kext (inside VoodooPS2Controller.kext).

DefinitionBlock ("", "SSDT", 2, "Lenovo", "_Swap", 0)
{
    External (_SB_.PCI0.LPCB.PS2K, DeviceObj)

    Scope (_SB.PCI0.LPCB.PS2K)
    {
        If (_OSI ("Darwin"))
        {
            Name (RMCF, Package ()
            {
                "Keyboard", 
                Package ()
                {
                    "Swap command and option", 
                    ">n"
                }
            })
        }
    }
}

