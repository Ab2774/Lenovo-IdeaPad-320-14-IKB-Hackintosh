// WARNING: this patch is only for Lenovo IdeaPad 320-14IKB
// May not work for your device.
// Override for host defined _OSI to handle "Darwin"

DefinitionBlock ("", "SSDT", 2, "Lenovo", "_XOSI", 0)
{
    Method (XOSI, 1, NotSerialized)
    {
        If (_OSI ("Darwin"))
        {
            If ((Arg0 == "Windows 2012"))
            {
                Return (0xFFFFFFFF)
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
