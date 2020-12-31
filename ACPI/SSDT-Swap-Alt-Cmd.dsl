// WARNING: this patch is only for Lenovo IdeaPad 320-14IKB
// May not work for your device
// Guide: https://github.com/Ab2774/Lenovo-IdeaPad-320-14-IKB-Hackintosh
// Swap Win to Command
// Pair with VoodooPS2Keyboard kext (inside VoodooPS2Controller kext)

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
                    ">y"
                }
            })
        }
    }
}

