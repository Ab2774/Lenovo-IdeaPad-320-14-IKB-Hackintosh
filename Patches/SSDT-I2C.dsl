// Lenovo IdeaPad 320 14-IKB Elan Touchpad Fix

DefinitionBlock ("", "SSDT", 2, "Lenovo", "_I2C", 0)
{
    External (SDM0, IntObj)
    External (_SB_.PCI0.I2C0, DeviceObj)
    External (FMDI, IntObj)
    External (FMHI, IntObj)
    External (FMLI, IntObj)
    External (SSDI, IntObj)
    External (SSHI, IntObj)
    External (SSLI, IntObj)
    
    Scope (_SB)
    {
        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            If (_OSI ("Darwin"))
            {
                SDM0 = Zero
            }
        }
    }
    
    Scope (_SB.PCI0.I2C0)
    {
        Method (PKG3, 3, Serialized)
        {
            Name (PKG, Package (0x03)
            {
                Zero, 
                Zero, 
                Zero
            })
            PKG [Zero] = Arg0
            PKG [One] = Arg1
            PKG [0x02] = Arg2
            Return (PKG) /* \_SB_.PCI0.I2C0.PKG3.PKG_ */
        }

        Method (SSCN, 0, NotSerialized)
        {
            Return (PKG3 (SSHI, SSLI, SSDI))
        }

        Method (FMCN, 0, NotSerialized)
        {
            Return (PKG3 (FMHI, FMLI, FMDI))
        }
    }
}
