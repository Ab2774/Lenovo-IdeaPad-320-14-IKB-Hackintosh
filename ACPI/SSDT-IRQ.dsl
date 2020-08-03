// WARNING: this patch is only for Lenovo IdeaPad 320-14IKB
// May not work for your device
// Guide: https://github.com/Ab2774/Lenovo-IdeaPad-320-14-IKB-Hackintosh
// Fix RTC, TIMR, and HPET devices by disabling them and adding counterfeit ones

DefinitionBlock ("", "SSDT", 2, "Lenovo", "_IRQ", 0)
{
    External (_SB_.PCI0.LPCB, DeviceObj)
    External (_SB_.PCI0.LPCB.RTC_, DeviceObj)
    External (_SB_.PCI0.LPCB.TIMR, DeviceObj)
    External (HPTE, IntObj)

    Scope (_SB)
    {
        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            If (_OSI ("Darwin"))
            {
                HPTE = Zero  // Disable High Precision Event Timer (HPET) device
            }
        }
    }

    Scope (_SB.PCI0.LPCB.RTC)  // Disable Real Time Clock (RTC) device
    {
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (Zero)
            }
            Else
            {
                Return (0x0F)
            }
        }
    }

    Scope (_SB.PCI0.LPCB.TIMR)  // Disable TIMR device
    {
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (Zero)
            }
            Else
            {
                Return (0x0F)
            }
        }
    }

    Device (HPE0)  // Add counterfeit High Precision Event Timer (HPE0) device
    {
        Name (_HID, EisaId ("PNP0103") /* HPET System Timer */)  // _HID: Hardware ID
        Name (_UID, Zero)  // _UID: Unique ID
        Name (BUF0, ResourceTemplate ()
        {
            IRQNoFlags ()
                {0,8}
            Memory32Fixed (ReadWrite,
                0xFED00000,         // Address Base
                0x00000400,         // Address Length
                )
        })
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }
            Else
            {
                Return (Zero)
            }
        }

        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
        {
            Return (BUF0) /* \HPE0.BUF0 */
        }
    }

    Device (RTC0)  // Add counterfeit Real Time Clock (RTC0) device
    {
        Name (_HID, EisaId ("PNP0B00") /* AT Real-Time Clock */)  // _HID: Hardware ID
        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            IO (Decode16,
                0x0070,             // Range Minimum
                0x0070,             // Range Maximum
                0x01,               // Alignment
                0x02,               // Length
                )
        })
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }
            Else
            {
                Return (Zero)
            }
        }
    }

    Device (TIM0)  // Add counterfeit TIM0 device
    {
        Name (_HID, EisaId ("PNP0100") /* PC-class System Timer */)  // _HID: Hardware ID
        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            IO (Decode16,
                0x0040,             // Range Minimum
                0x0040,             // Range Maximum
                0x01,               // Alignment
                0x04,               // Length
                )
            IO (Decode16,
                0x0050,             // Range Minimum
                0x0050,             // Range Maximum
                0x10,               // Alignment
                0x04,               // Length
                )
        })
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }
            Else
            {
                Return (Zero)
            }
        }
    }
}

