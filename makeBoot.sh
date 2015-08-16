#! /bin/bash
printf "----------------------------------------------------\n"
printf "|Welcome, I will turn an ISO into a bootable drive!|\n"
printf "----------------------------------------------------\n"
printf "Please enter the *FULL* path to the ISO file: "
read ISOpath
mkdir ~/tempBootDir
hdiutil convert -format UDRW -o ~/tempBootDir/newFile.img $ISOpath
mv ~/tempBootDir/newFile.img.dmg ~/tempBootDir/newFile.img
##### File has been created
printf "----------------------------------------\n"
printf "Here is a list of your connected devices\n"
printf "----------------------------------------\n"
diskutil list | grep -e '/dev\|#:\|0:'
printf "Enter disk you wish to use (Ex. disk1): "
read diskNum
notThis='disk0'
if [[ *"$diskNum"* == *"$notThis"* ]];then
	printf "I will not allow you to do this to the internal drive on your computer!\n"
	printf "Sorry friend if you REALLY wanna do this then you can do it by hand yourself\n"
	exit
fi
diskutil unmountDisk $diskNum
sudo dd if=~/tempBootDir/newFile.img of=/dev/r$diskNum bs=1m
echo "Cleaning up..."
rm -rf ~/tempBootDir
