// WARNING: this patch is only for Lenovo IdeaPad 320-14IKB
// May not work for your device.
// Lenovo IdeaPad 320 14-IKB keyboard remap PrtSc to F13
// Could then be mapped to one of the image capture functions via SysPrefs->Keyboard->Shortcuts. 
// Pair with VoodooPS2Keyboard.kext (inside VoodooPS2Controller.kext).

DefinitionBlock ("", "SSDT", 2, "Lenovo", "_F13", 0)
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
                    "Custom PS2 Map", 
                    Package ()
                    {
                        Package (){}, 
                        "e037=64" // PrtSc=F13
                    }
                }
            })
        }
    }
}

