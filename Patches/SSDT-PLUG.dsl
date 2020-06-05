// WARNING: this patch is only for Lenovo IdeaPad 320-14IKB
// May not work for your device.
// Enable power managment by injecting plugin-type=1 for Lenovo IdeaPad 320 14-IKB.

DefinitionBlock ("", "SSDT", 2, "Lenovo", "_PLUG", 0)
{
    External (_PR_.CPU0, ProcessorObj)

    Scope (_PR.CPU0)
    {
        If (_OSI ("Darwin"))
        {
            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
            {
                If (!Arg2)
                {
                    Return (Buffer (One)
                    {
                         0x03                                            
                    })
                }

                Return (Package ()
                {
                    "plugin-type", 
                    One
                })
            }
        }
    }
}
