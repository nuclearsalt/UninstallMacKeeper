#!/bin/bash

read -p "WARNING - If you have encrypted any files with MacKeeper, please open MacKeeper and decrypt those files. If you don't do this, you're gonna have a bad time. Type 'ok' and hit ENTER to continue, or type 'quit' to quit this uninstaller: " ok

if [[ $ok = "ok" || $ok = "OK" || $ok = "Ok" ]] ; then
	:
else
	exit 0
fi

echo "Please enter your administrator password: "
sudo echo "Beginning Uninstall Script"
sleep 3

#Kill Processes Related to MacKeeper
echo "Stopping Processes"
killall "MacKeeper Helper"
sudo kill $(ps aux | grep '[M]acKeeper.app' | awk '{print $2}')
sudo kill $(ps aux | grep '[A]ntiVirus.app' | awk '{print $2}')

### include entry for removing Safari Plugins
### include entry for removing cookies
### include entry for removing MacKeeper from Startup Items

#Launch Agents
Echo "Deleting Launch Agents"
rm ~/Library/Launch\ Agents/com.zeobit.MacKeeper.Helper
rm ~/Library/Launch\ Agents/com.zeobit.MacKeeper.plugin.Backup.agent
rm ~/Library/Launch\ Agents/com.mackeeper.MacKeeper.Helper.plist

#Preferences
echo "Deleting Preference Files"
rm ~/Library/Preferences/com.zeobit.MacKeeper.*
rm ~/Library/Preferences/com.mackeeper.MacKeeper.*

#Logs
echo "Deleting Logs"
rm ~/Library/Logs/MacKeeper.log
rm ~/Library/Logs/MacKeeper.log.signed

#Temp Files
echo "Deleting Temp Files"
sudo rm -R /private/tmp/com.mackeeper.MacKeeper.Installer.config

#Backups
read -p "You have the option to delete your MacKeeper Backups. Would you like to do this? y/n: " del

if [[ $del = "y" || $del = "Y" ]] ; then
	echo "Deleting backups"
	sleep 3
	rm -R ~/Documents/MacKeeper\ Backups
else 
	:
fi	

#remove MacKeeper Application
echo "Removing MacKeeper Application"
sudo rm -R /Applications/MacKeeper.app

#remove MacKeeper from Keychain
read -p "You should remove the MacKeeper entry from your keychain. Do you want instructions for how to do this? y/n " ins

if [[ $ins = "y" || $ins = "Y" ]] ; then
	echo "A browser will now open to a website with instructions on how to remove MacKeeper from your keychain. You may need to scroll down a bit to find the section having to do with keychains."
	sleep 6
	open http://www.chriswrites.com/how-to-completely-remove-mackeeper-from-your-macbook/
else
	:
fi

echo "MacKeeper has been removed from your system. Good riddens."

exit 0

