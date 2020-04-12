// WARNING: this patch is only for Lenovo IdeaPad 320-14IKB
// May not work for your device.
// Lenovo IdeaPad 320 14-IKB Keyboard map.

DefinitionBlock ("", "SSDT", 2, "Lenovo", "_KBD", 0)
{
    External (_SB.PCI0.LPCB.EC0, DeviceObj)
    External (_SB.PCI0.LPCB.KBD0.RMCF, DeviceObj)
    External (_SB.PCI0.LPCB.EC0.XQ1C, MethodObj)
    External (_SB.PCI0.LPCB.EC0.XQ1D, MethodObj)

    Scope (_SB.PCI0.LPCB.EC0)
    {
        Method (_Q1D, 0, NotSerialized) // (F11) Brightness Down
        {
            If (_OSI ("Darwin"))
            {
                Notify (KBD0, 0x0405)
            }
            Else
            {
                \_SB.PCI0.LPCB.EC0.XQ1C ()
            }
        }
        Method (_Q1C, 0, NotSerialized) // (F12) Brightness Up
        {
            If (_OSI ("Darwin"))
            {
                Notify (KBD0, 0x0406)
            }
            Else
            {
                \_SB.PCI0.LPCB.EC0.XQ1D ()
            }
          }
        }
    }