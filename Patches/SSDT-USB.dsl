// WARNING: this patch is only for Lenovo IdeaPad 320-14IKB
// May not work for your device.
// USB Ports Injector and USB Ports Power for Lenovo IdeaPad 320 14-IKB.
// Pair with USBPorts.kext.

DefinitionBlock ("", "SSDT", 2, "Lenovo", "_USB", 0)
{
    Device (_SB.USBX)
    {
        Name (_ADR, Zero)  // _ADR: Address
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

        Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
        {
            If (!Arg2)
            {
                Return (Buffer ()
                {
                     0x03                                          
                })
            }

            Return (Package ()
            {
                "kUSBSleepPortCurrentLimit", 
                0x0834, 
                "kUSBWakePortCurrentLimit", 
                0x0834
            })
        }
    }

    Device (UIAC)
    {
        Name (_HID, "UIA00000")  // _HID: Hardware ID
        Name (RMCF, Package ()
        {
            "8086_9d2f", 
            Package ()
            {
                "port-count", 
                Buffer ()
                {
                     0x15, 0x00, 0x00, 0x00                         
                }, 

                "ports", 
                Package ()
                {
                    "HS01", // USB 3.0 First
                    Package ()
                    {
                        "UsbConnector", 
                        0x03, 
                        "port", 
                        Buffer ()
                        {
                             0x01, 0x00, 0x00, 0x00                          
                        }
                    }, 

                    "HS02", // USB 3.0 
                    Package ()
                    {
                        "UsbConnector", 
                        0x09, 
                        "port", 
                        Buffer ()
                        {
                             0x02, 0x00, 0x00, 0x00                           
                        }
                    },
                    
                     "HS03", // USB 3.0 Second
                    Package ()
                    {
                        "UsbConnector", 
                        0x03, 
                        "port", 
                        Buffer ()
                        {
                             0x03, 0x00, 0x00, 0x00                           
                        }
                    }, 

                    "HS04", 
                    Package ()
                    {
                        "UsbConnector", 
                        0xFF, 
                        "port", 
                        Buffer ()
                        {
                             0x04, 0x00, 0x00, 0x00                  
                        }
                    }, 

                    "HS05", // SD Card Reader
                    Package ()
                    {
                        "UsbConnector", 
                        0x00, 
                        "port", 
                        Buffer ()
                        {
                             0x05, 0x00, 0x00, 0x00                           
                        }
                    }, 

                    "HS06", 
                    Package ()
                    {
                        "UsbConnector", 
                        0x03, 
                        "port", 
                        Buffer ()
                        {
                             0x06, 0x00, 0x00, 0x00                          
                        }
                    },
                    
                    "HS07", // Integrated Camera
                    Package ()
                    {
                        "UsbConnector", 
                        0xFF, 
                        "port", 
                        Buffer ()
                        {
                             0x07, 0x00, 0x00, 0x00                          
                        }
                    },
                    
                     "HS08", // Bluetooth
                    Package ()
                    {
                        "UsbConnector", 
                        0xFF, 
                        "port", 
                        Buffer ()
                        {
                             0x08, 0x00, 0x00, 0x00                          
                        }
                    }, 
                    
                     "HS09", 
                    Package ()
                    {
                        "UsbConnector", 
                        0x03, 
                        "port", 
                        Buffer ()
                        {
                             0x09, 0x00, 0x00, 0x00                          
                        }
                    }, 

                    "HS10",
                    Package ()
                    {
                        "UsbConnector", 
                        0x03, 
                        "port", 
                        Buffer ()
                        {
                             0x0A, 0x00, 0x00, 0x00                           
                        }
                    }, 

                    "SS01", 
                    Package ()
                    {
                        "UsbConnector", 
                        0x03, 
                        "port", 
                        Buffer ()
                        {
                             0x0B, 0x00, 0x00, 0x00                           
                        }
                    }, 

                    "SS02",
                    Package ()
                    {
                        "UsbConnector", 
                        0x09, 
                        "port", 
                        Buffer ()
                        {
                             0x0C, 0x00, 0x00, 0x00                          
                        }
                    }, 

                    "SS03",
                    Package ()
                    {
                        "UsbConnector", 
                        0x03, 
                        "port", 
                        Buffer ()
                        {
                             0x0D, 0x00, 0x00, 0x00                          
                        }
                    },
                    
                    "USR1",
                    Package ()
                    {
                        "UsbConnector", 
                        0x03, 
                        "port", 
                        Buffer ()
                        {
                             0x0E, 0x00, 0x00, 0x00                          
                        }
                    }, 

                    "USR2", 
                    Package ()
                    {
                        "UsbConnector", 
                        0x03, 
                        "port", 
                        Buffer ()
                        {
                             0x0F, 0x00, 0x00, 0x00                          
                        }
                    }
                }
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

