# Install-SynergyDE.ps1
This Powershell DSC Script provides a simple example of how to install SynergyDE using the built-in Resource MsiPackage ([Powershell DSC: MsiPackage](https://github.com/PowerShell/PSDscResources#msipackage))

## Requirements
* Extracted MSI
    * See [Extracting The Synergy Runtime MSI Installer](https://github.com/aolszowka/xSynergyDE/wiki/Extracting-The-Synergy-Runtime-MSI-Installer)
    * This is a limitation of `MsiPackage`
* Valid Synergy License Server

## Limitations
* Right now the installers are expected to exist on a local folder on the machine being configured.
    * In theory we should have been able to use the `Credential` argument of `MsiPackage` to point it to the MSI. However in testing this did not appear to work. It is believed that this is due to the way InstallShield created the MSI and that `MsiPackage` probably assumes that it only needs access to the MSI and not the folder which can contain CAB Files.
* This will only configure Synergy/DE as a network client

## Hacking
* If you only need to install the 32bit of 64bit version you can delete the `MsiPackage` resource for the appropriate version.
* You will need to change `$SYNERGY_LICENSE_SERVER` to suit your needs.
* You will probably want to play around with the `FEATURES_TO_INSTALL` variable to suit your needs.

## Running
In testing this script, use the following Powershell Command:

`Start-DscConfiguration -Path S:\GitHub\xSynergyDE\Examples\CommonTasks\Installing\SynergyDE -Wait -Verbose -Force`

Make sure to change the folder path to the one that the MOF exists at.
