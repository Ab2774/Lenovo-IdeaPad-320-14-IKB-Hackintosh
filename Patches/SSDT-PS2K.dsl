// Lenovo IdeaPad 320 14-IKB Keyboard Map

DefinitionBlock ("", "SSDT", 2, "Lenovo", "PS2K", 0)
{
    External (_SB.PCI0.LPCB.EC0, DeviceObj)
    External (_SB.PCI0.LPCB.PS2K.RMCF, DeviceObj)
    External (SDM0, IntObj)

    Scope (_SB.PCI0.LPCB.EC0)
    {
        Method (_Q1C, 0, NotSerialized) // (F15) Brightness Up
        {
            Notify (PS2K, 0x0406)
        }
        Method (_Q1D, 0, NotSerialized) // (F14) Brightness Down
        {
            Notify (PS2K, 0x0405)
            }
        }
    }
