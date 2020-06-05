// WARNING: this patch is only for Lenovo IdeaPad 320-14IKB
// May not work for your device.
// Lenovo IdeaPad 320 14-IKB ELAN and Synaptics Trackpad Fix.
// Pair with VoodooI2C.kext
// VoodooI2CELAN.kext (for ELAN users)
// VoodooI2CSynaptics.kext (for Synaptics users)

DefinitionBlock ("", "SSDT", 2, "Lenovo", "_I2C", 0)
{
    External (_SB_.PCI0.I2C0, DeviceObj)
    External (_SB_.PCI0.I2C0.TPD0, DeviceObj)
    External (_SB_.PCI0.I2C0.TPD0.SBFG, IntObj)
    External (_SB_.PCI0.I2C0.TPD0.SBFS, IntObj)

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

        Name (SSCN, Package ()
        {
            0x01B0, 
            0x01FB, 
            0x1E
        })
        Name (FMCN, Package ()
        {
            0x48, 
            0xA0, 
            0x1E
        })
    }

    Scope (_SB.PCI0.I2C0.TPD0)
    {
        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
        {
            If (_OSI ("Darwin")){}
            Return (ConcatenateResTemplate (SBFS, SBFG))
        }
    }
}

