// WARNING: this patch is only for Lenovo IdeaPad 320-14IKB
// May not work for your device.
// Solving instant wake by hooking GPRW or UPRW 
// for Lenovo IdeaPad 320 14-IKB.

DefinitionBlock("", "SSDT", 2, "Lenovo", "_GPRW", 0)
{
    External (XPRW, MethodObj)    // 2 Arguments

    Method (GPRW, 2, NotSerialized)
    {
        If (_OSI ("Darwin"))
        {
            If ((0x6D == Arg0))
            {
                Return (Package (0x02)
                {
                    0x6D, 
                    Zero
                })
            }

            Return (XPRW (Arg0, Arg1))
        }
        Else
        {
            Return (XPRW (Arg0, Arg1))
        }
    }
}

