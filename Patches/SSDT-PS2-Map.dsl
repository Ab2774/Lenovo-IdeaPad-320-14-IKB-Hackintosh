// WARNING: this patch is only for Lenovo IdeaPad 320-14IKB
// May not work for your device.
// Lenovo IdeaPad 320 14-IKB keyboard remap PrtSc to F13 and swap Command to Win.

DefinitionBlock ("", "SSDT", 2, "Lenovo", "_PS2K", 0)
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
                }, 
                
                "Swap command and option", // Command to Win; otherwise, Command to Alt
                ">n"
                    }
                }
            )
        }
    }
}

