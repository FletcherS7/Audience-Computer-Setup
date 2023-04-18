echo "   ____ __  __ ____       _   _   _ ____ ___    _    _   _  ____ _____ "
echo "  / ___|  \/  |  _ \     / \ | | | |  _ \_ _|  / \  | \ | |/ ___| ____|"
echo " | |   | |\/| | |_) |   / _ \| | | | | | | |  / _ \ |  \| | |   |  _|  "
echo " | |___| |  | |  __/   / ___ \ |_| | |_| | | / ___ \| |\  | |___| |___ "
echo "  \____|_| _|_|_|___ _/_/_ _\_\___/|____/___/_/___\_\_|_\_|\____|_____|"
echo " | |      / \  |  _ \_   _/ _ \|  _ \  / ___|| ____|_   _| | | |  _ \  "
echo " | |     / _ \ | |_) || || | | | |_) | \___ \|  _|   | | | | | | |_) | "
echo " | |___ / ___ \|  __/ | || |_| |  __/   ___) | |___  | | | |_| |  __/  "
echo " |_____/_/   \_\_|    |_| \___/|_|     |____/|_____| |_|  \___/|_|     "
echo "                                                                       "
echo "Created by Fletcher Salesky and Ed Jordan"
echo "Created on 2023-04-17"


#Stop Windows updates
net stop wuauserv
echo "Windows Update Service Stopped"
sc.exe config wuauserv start= disabled
echo "Windows Update Service Disabled"
echo " "
echo " "


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

#Set timezone
echo "Setting time zone to Central Standard Time"
Set-TimeZone -Id "Central Standard Time"

#Prompt for computer name
$HostName = Read-Host -Prompt 'Input the computer name'

Rename-Computer -NewName "$HostName"

Start-Sleep -s 5

#restart computer
Restart-Computer
echo "Restarting Computer"