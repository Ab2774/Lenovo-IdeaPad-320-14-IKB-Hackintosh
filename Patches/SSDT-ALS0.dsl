// WARNING: this patch is only for Lenovo IdeaPad 320-14IKB
// May not work for your device.
// Add ambient light sensor device for Lenovo IdeaPad 320-14IKB.
// Pair with VirtualSMC.kext and SMCLightSensor.kext.

DefinitionBlock ("", "SSDT", 2, "Lenovo", "_ALS0", 0)
{
    Device (ALS0)
    {
        Name (_HID, "ACPI0008" /* Ambient Light Sensor Device */)  // _HID: Hardware ID
        Name (_CID, "smc-als")  // _CID: Compatible ID
        Name (_ALI, 0x012C)  // _ALI: Ambient Light Illuminance
        Name (_ALR, Package ()  // _ALR: Ambient Light Response
        {
            Package ()
            {
                0x64, 
                0x012C
            }
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
