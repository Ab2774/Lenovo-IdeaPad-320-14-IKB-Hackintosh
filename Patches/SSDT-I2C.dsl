// WARNING: this patch is only for Lenovo IdeaPad 320-14IKB
// May not work for your device.
// Lenovo IdeaPad 320 14-IKB Elan Trackpad Fix.

DefinitionBlock("", "SSDT", 2, "Lenovo", "_I2C", 0)
{
    External (_SB_.PCI0.I2C0, DeviceObj)
    External (_SB_.PCI0.I2C0.TPD0, DeviceObj)
    External (_SB_.PCI0.I2C0.TPD0.SBFB, UnknownObj)
    External (_SB_.PCI0.I2C0.TPD0.SBFG, UnknownObj)
    External (_SB_.PCI0.I2C0.TPD0.SBFI, UnknownObj)
    External (OSYS, FieldUnitObj)
    External (SDM0, FieldUnitObj)

    Scope (_SB.PCI0.I2C0.TPD0)
    {
        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
        {
            If (_OSI ("Darwin"))
            {
                Return (ConcatenateResTemplate (SBFB, SBFG))
            }

            If ((OSYS < 0x07DC))
            {
                Return (SBFI) /* External reference */
            }

            If ((SDM0 == Zero))
            {
                Return (ConcatenateResTemplate (SBFB, SBFG))
            }

            Return (ConcatenateResTemplate (SBFB, SBFI))
            }
        }
     Scope (_SB.PCI0.I2C0)
    {
        If (_OSI ("Darwin"))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
        } 
                
        Name (SSCN, Package (0x03)
        {
            0x01B0, 
            0x01FB, 
            0x1E
        })
        Name (FMCN, Package (0x03)
        {
            0x48, 
            0xA0, 
            0x1E
        })
        
    }
}
