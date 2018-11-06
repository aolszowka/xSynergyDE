# This PowerShell DSC Script Will Ensure that SynergyDE 32 and 64 Are Installed
# MIT Licensed
# Copyright (c) 2018 Ace Olszowka
Configuration SynergyDE
{
    Import-DscResource -ModuleName PSDscResources

    # Change this setting to determine if this verison of SynergyDE should exist
    # (be installed) or not.
    $EnsureSynergyDE = "Present"

    # In order for PowerShell DSC's MsiPackage to work you must have extracted
    # the MSI from the InstallShield Installer otherwise this will not work.
    # See https://github.com/aolszowka/xSynergyDE/wiki/Extracting-The-Synergy-Runtime-MSI-Installer
    $SYNERGY_X64_MSI_INSTALLER = "C:\SynergyMSI\104SDE1033F\104SDE1033F.msi"
    $SYNERGY_X86_MSI_INSTALLER = "C:\SynergyMSI\101SDE1033F\101SDE1033F.msi"

    # In addition you MUST extract the PackageGuid/Product Code from these MSI
    # See https://github.com/aolszowka/xSynergyDE/wiki/SynergyDE-Installer-GUIDs
    $SYNERGY_X64_MSI_GUID = "{28B1A806-D679-4DF8-93BD-08EEDAE6F4F1}"
    $SYNERGY_X86_MSI_GUID = "{BA4D0151-279D-4D5A-914F-F8E875643990}"

    # This DSC Script Assumes that you want to configure yourself as a client
    # therefore you MUST provide the License Server
    $SYNERGY_LICENSE_SERVER = "synlm.example.com"

    # These features should be Comma Seperated
    # See https://github.com/aolszowka/xSynergyDE/wiki/SynergyDE-Installer-Features
    $SYNERGY_X64_FEATURES_TO_INSTALL = "CC,CN,XS"
    $SYNERGY_X86_FEATURES_TO_INSTALL = "CC,CN,XS"

    Node 'localhost'
    {
        # SynergyDE32 Install
        MsiPackage SynergyDE32
        {
            Ensure    = $EnsureSynergyDE
            Path      = $SYNERGY_X86_MSI_INSTALLER
            ProductId = $SYNERGY_X86_MSI_GUID
            Arguments = "/qn LICENSETYPE=Client SERVERNAME=$SYNERGY_LICENSE_SERVER ADDLOCAL=$SYNERGY_X86_FEATURES_TO_INSTALL"
        }

        # SynergyDE64 Install
        MsiPackage SynergyDE64
        {
            Ensure    = $EnsureSynergyDE
            Path      = $SYNERGY_X64_MSI_INSTALLER
            ProductId = $SYNERGY_X64_MSI_GUID
            Arguments = "/qn LICENSETYPE=Client SERVERNAME=$SYNERGY_LICENSE_SERVER ADDLOCAL=$SYNERGY_X64_FEATURES_TO_INSTALL"
        }
    }
}

# Change this section if you are installing on specific machines
$cd = @{
    AllNodes = @(
        @{
            NodeName = 'localhost'
        }
    )
}

SynergyDE $cd