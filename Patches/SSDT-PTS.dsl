// Lenovo Ideapad 320 14-IKB Auto Start after Shutdown Fix when a USB is plugged in

DefinitionBlock ("", "SSDT", 2, "Lenovo", "_PTS", 0)
{
    External (_SB_.PCI0.XHC_.PMEE, FieldUnitObj)
    External (ZPTS, MethodObj)
    Method(_PTS, 1)
    {
        ZPTS(Arg0)
        If (5 == Arg0)
        {
            \_SB.PCI0.XHC.PMEE = Zero
        }
    }
}
