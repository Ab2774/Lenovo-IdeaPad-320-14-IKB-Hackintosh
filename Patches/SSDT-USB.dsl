// USB Ports Injector for Lenovo IdeaPad 320 14-IKB.
// USB Power Properties from MacBookPro14,1

DefinitionBlock ("", "SSDT", 2, "Lenovo", "_USB", 0)
{
    Device(UIAC)
    {
        Name(_HID, "UIA00000")
        Name(RMCF, Package()
        {
            // USB Power Properties for Sierra+ (using USBInjectAll injection)
            "AppleBusPowerController", Package()
            {
                // these values from MacBookPro14,1
                "kUSBSleepPortCurrentLimit", 3000,
                "kUSBWakePortCurrentLimit", 3000,
            },
            "8086_9d2f", Package()
            {
                "ports", Package()
                {
                    "HS01", Package()
                    {
                          "UsbConnector", 3,
                          "port", Buffer() { 0x01, 0x00, 0x00, 0x00 },
                      },
                      "SS02", Package()
                      {
                          "UsbConnector", 3,
                          "port", Buffer() { 0x0E, 0x00, 0x00, 0x00 },
                      },
                      "HS08", Package()
                      {
                          "UsbConnector", 3,
                          "port", Buffer() { 0x08, 0x00, 0x00, 0x00 },
                      },
                      "HS04", Package()
                      {
                          "UsbConnector", 3,
                          "port", Buffer() { 0x04, 0x00, 0x00, 0x00 },
                      },
                      "USR2", Package()
                      {
                          "UsbConnector", 3,
                          "port", Buffer() { 0x0C, 0x00, 0x00, 0x00 },
                      },
                      "HS10", Package()
                      {
                          "UsbConnector", 3,
                          "port", Buffer() { 0x0A, 0x00, 0x00, 0x00 },
                      },
                      "SS01", Package()
                      {
                          "UsbConnector", 3,
                          "port", Buffer() { 0x0D, 0x00, 0x00, 0x00 },
                      },
                      "HS07", Package()
                      {
                          "UsbConnector", 3,
                          "port", Buffer() { 0x07, 0x00, 0x00, 0x00 },
                      },
                      "HS03", Package()
                      {
                          "UsbConnector", 3,
                          "port", Buffer() { 0x03, 0x00, 0x00, 0x00 },
                      },
                      "USR1", Package()
                      {
                          "UsbConnector", 3,
                          "port", Buffer() { 0x0B, 0x00, 0x00, 0x00 },
                      },
                      "HS06", Package()
                      {
                          "UsbConnector", 3,
                          "port", Buffer() { 0x06, 0x00, 0x00, 0x00 },
                      },
                      "HS02", Package()
                      {
                          "UsbConnector", 3,
                          "port", Buffer() { 0x02, 0x00, 0x00, 0x00 },
                      },
                      "SS03", Package()
                      {
                          "UsbConnector", 3,
                          "port", Buffer() { 0x0F, 0x00, 0x00, 0x00 },
                      },
                      "HS09", Package()
                      {
                          "UsbConnector", 3,
                          "port", Buffer() { 0x09, 0x00, 0x00, 0x00 },
                      },
                      "HS05", Package()
                      {
                          "UsbConnector", 3,
                          "port", Buffer() { 0x05, 0x00, 0x00, 0x00 },
                      },
                },
            },
        })
    }
}
