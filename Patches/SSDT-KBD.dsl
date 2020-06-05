// WARNING: this patch is only for Lenovo IdeaPad 320-14IKB
// May not work for your device.
// Lenovo IdeaPad 320 14-IKB Brightness Keyboard Shortcut.
// Pair with VoodooPS2Keyboard.kext (inside VoodooPS2Controller.kext).

DefinitionBlock ("", "SSDT", 2, "Lenovo", "_KBD", 0)
{
    External (_SB_.PCI0.LPCB.EC__, DeviceObj)
    External (_SB_.PCI0.LPCB.EC__.XQ1C, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.EC__.XQ1D, MethodObj)    // 0 Arguments  
    External (_SB_.PCI0.LPCB.KBD0, DeviceObj)

    Scope (_SB.PCI0.LPCB.EC)
    {
        Method (_Q1D, 0, NotSerialized) // (F11) Brightness Down
        {
            If (_OSI ("Darwin"))
            {
                Notify (KBD0, 0x0405)
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ1C ()
            }
        }

        Method (_Q1C, 0, NotSerialized)  // (F12) Brightness Up
        {
            If (_OSI ("Darwin"))
            {
                Notify (KBD0, 0x0406)
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ1D ()
            }
        }
    }
}
