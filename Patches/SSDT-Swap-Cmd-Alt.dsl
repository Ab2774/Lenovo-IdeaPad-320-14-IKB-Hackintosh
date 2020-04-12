// WARNING: this patch is only for Lenovo IdeaPad 320-14IKB
// May not work for your device.
// Lenovo IdeaPad 320 14-IKB keyboard remap by swapping Command to Win.

DefinitionBlock ("", "SSDT", 2, "ACDT", "_Swap", 0)
{
    Name(_SB.PCI0.LPCB.PS2K.RMCF, Package()
    {
        "Keyboard", Package()
        {
            "Swap command and option", // Command to Win; otherwise, Command to Alt
            ">n",
        },
    })
}
