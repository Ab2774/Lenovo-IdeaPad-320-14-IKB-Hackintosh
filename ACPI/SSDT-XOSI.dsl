// WARNING: this patch is only for Lenovo IdeaPad 320-14IKB
// May not work for your device
// Guide: https://github.com/Ab2774/Lenovo-IdeaPad-320-14-IKB-Hackintosh
// Override for host defined _OSI to handle "Darwin"
// Pair with _OSI to XOSI Rename Method

DefinitionBlock ("", "SSDT", 2, "Lenovo", "_XOSI", 0)
{
    Method (XOSI, 1, NotSerialized)
    {
        If (_OSI ("Darwin"))
        {
            If ((Arg0 == "Windows 2012"))
            {
                Return (0x0F)
            }
            Else
            {
                Return (Zero)
            }
        }
        Else
        {
            Return (_OSI (Arg0))
        }
    }
}

