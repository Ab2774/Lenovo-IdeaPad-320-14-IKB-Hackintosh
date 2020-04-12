// WARNING: this patch is only for Lenovo IdeaPad 320-14IKB
// May not work for your device.
// Disable HPET device for Lenovo IdeaPad 320 14-IKB.

DefinitionBlock ("", "SSDT", 2, "Lenovo", "_HPET", 0)
{
    External (_SB_.PCI0.LPCB.HPET, DeviceObj)
    External (HPTE, FieldUnitObj)

    Scope (_SB.PCI0.LPCB.HPET)
    {
        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            If (_OSI ("Darwin"))
            {
                HPTE = Zero
            }
        }
    }
}

