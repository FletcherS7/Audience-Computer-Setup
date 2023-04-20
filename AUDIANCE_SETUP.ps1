echo "     _   _   _ ____ ___    _    _   _  ____ _____                     "
echo "    / \ | | | |  _ \_ _|  / \  | \ | |/ ___| ____|                    "
echo "   / _ \| | | | | | | |  / _ \ |  \| | |   |  _|                      "
echo "  / ___ \ |_| | |_| | | / ___ \| |\  | |___| |___                     "
echo " /_/   \_\___/|____/___/_/ __\_\_|_\_|\____|_____|_ _____ _   _ ____  "
echo " | |      / \  |  _ \_   _/ _ \|  _ \  / ___|| ____|_   _| | | |  _ \ "
echo " | |     / _ \ | |_) || || | | | |_) | \___ \|  _|   | | | | | | |_) |"
echo " | |___ / ___ \|  __/ | || |_| |  __/   ___) | |___  | | | |_| |  __/ "
echo " |_____/_/   \_\_|    |_| \___/|_|     |____/|_____| |_|  \___/|_|    "
echo "                                                                      "
echo "Created by Fletcher Salesky and Ed Jordan"
echo "Created on 2023-04-17"
#This script was created to mass configure FRC Audiance Display Toughbooks.
#Pre Configure the TimeZone setting below BEFORE using this script


#Set timezone 
#Edit this to reflect your timezone, get full list with "Get-TimeZone -ListAvailable" PowerShell Command
#Replace the below variable with the Id value from the ListAvailable command
$TimeZone = "Central Standard Time"

echo "Setting time zone to $TimeZone"
Set-TimeZone -Id "$TimeZone"


#Stop Windows Update Service
net stop wuauserv
echo "Windows Update Service Stopped"
#Disable Windows Update Service (Can cause instability)
#sc.exe config wuauserv start= disabled
#echo "Windows Update Service Disabled"
echo " "
echo " "

#Set Active Hours
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings -Name ActiveHoursStart -Value 7 -PassThru
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings -Name ActiveHoursEnd -Value 20 -PassThru
$ahs = Get-Item -Path HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings
#Display Active Hours
echo "Active Hours Set"
$ahsoutput = [ordered]@{
   ActiveHoursStart = $ahs.GetValue(‘ActiveHoursStart’)
   ActiveHoursEnd = $ahs.GetValue(‘ActiveHoursEnd’)
}
echo $ahsoutput


#Set Connection to Private
echo "Setting Connection as Private"
Set-NetConnectionProfile -NetworkCategory "Private"

#Disable Sleep
echo "Disabling ScreenTimeout and Computer Sleep"
powercfg /change monitor-timeout-ac 0
powercfg /change monitor-timeout-dc 0
powercfg /change disk-timeout-ac 0
powercfg /change disk-timeout-dc 0
powercfg /change standby-timeout-ac 0
powercfg /change standby-timeout-dc 0
powercfg /change hibernate-timeout-ac 0
powercfg /change hibernate-timeout-dc 0
#Diable System unattended sleep timeout
powercfg /SETDCVALUEINDEX SCHEME_CURRENT 238C9FA8-0AAD-41ED-83F4-97BE242C8F20 7bc4a2f9-d8fc-4469-b07b-33eb785aaca0 0
powercfg /SETACVALUEINDEX SCHEME_CURRENT 238C9FA8-0AAD-41ED-83F4-97BE242C8F20 7bc4a2f9-d8fc-4469-b07b-33eb785aaca0 0
#Disable Console lock display off timeout
powercfg /SETDCVALUEINDEX SCHEME_CURRENT 7516b95f-f776-4464-8c53-06167f40cc99 8ec4b3a5-6868-48c2-be75-4f3044be88a7 0
powercfg /SETACVALUEINDEX SCHEME_CURRENT 7516b95f-f776-4464-8c53-06167f40cc99 8ec4b3a5-6868-48c2-be75-4f3044be88a7 0

#Set Computer Name
$HostNameStatic = "FRCFIELD-"
#Prompt for computer name
echo "Input Unique Computer Name"
echo "Name will start with 'FRCFIELD-'"
echo "Suggested value is field number followed by a letter for the toughbook (Example for Truck1: 1A, 1B, 1C, etc)"
$HostNameInput = Read-Host -Prompt 'Input unique value FRCFIELD-'
echo "$HostNameStatic$HostNameInput"

Rename-Computer -NewName "$HostNameStatic$HostNameInput"

echo "COMPUTER WILL NOW RESTART TO APPLY CHANGES"
Start-Sleep -s 8

#restart computer
Restart-Computer
echo "Restarting Computer"