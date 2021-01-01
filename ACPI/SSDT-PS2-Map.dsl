// WARNING: this patch is only for Lenovo IdeaPad 320-14IKB
// May not work for your device
// Guide: https://github.com/Ab2774/Lenovo-IdeaPad-320-14-IKB-Hackintosh
// Complete keyboard patches
// Pair with VoodooPS2Keyboard kext (inside VoodooPS2Controller kext)

DefinitionBlock ("", "SSDT", 2, "Lenovo", "_PS2Map", 0)
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
                    "Breakless PS2", 
                    Package ()
                    {
                        Package (){}, 
                        "e06a",
                        "e06b"
                    }, 

                    "Macro Inversion", 
                    Package ()
                    {
                        Buffer ()
                        {
                            0xFF, 0xFF, 0x02, 0x6A, 0x00, 0x00,
                            0x00, 0x00, 0x02, 0x5B, 0x01, 0x26
                        }, 

                        Buffer ()
                        {
                            0xFF, 0xFF, 0x02, 0xEA, 0x00, 0x00,
                            0x00, 0x00, 0x01, 0x99, 0x02, 0xDB
                        }, 

                        Buffer ()
                        {
                            0xFF, 0xFF, 0x02, 0x6B, 0x00, 0x00,
                            0x00, 0x00, 0x02, 0x5B, 0x01, 0x19
                        }, 

                        Buffer ()
                        {
                            0xFF, 0xFF, 0x02, 0xEB, 0x00, 0x00,
                            0x00, 0x00, 0x01, 0x99, 0x02, 0xDB
                        }
                    }, 

                    "Custom ADB Map", 
                    Package ()
                    {
                        Package (){}, 
                        "3b=4a",  // (F1) Volume Mute
                        "3c=49",  // (F2) Volume Down
                        "3d=48",  // (F3) Volume Up
                        "e06a=65",  // F9
                        "e06b=6d",  // F10
                        "57=6b",  // F11=14
                        "58=71"  // F12=F15
                    }, 

                    "Custom PS2 Map", 
                    Package ()
                    {
                        Package (){}, 
                        "e037=64",  // PrtSc=F13
                        "40=e037",  // F9=PrtSc (Disable Trackpad)
                        "e053=0e",  // Delete=Backspace
                        "46=2e",  // Fn+C=C
                        "e045=19"  // Fn+P=P
                    }, 

                    "RemapPrntScr",  // Enable PrtSc
                    ">y", 
                    "Swap command and option",  // Command to Win
                    ">n"
                }
            })
        }
    }
}

