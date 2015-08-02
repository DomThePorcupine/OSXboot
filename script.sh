#! /bin/bash
echo "----------------------------------------------------"
echo "|Welcome, I will turn an ISO into a bootable drive!|"
echo "----------------------------------------------------"
printf "Please enter the *FULL* path to the ISO file: "
read ISOpath
echo $ISOpath
mkdir ~/xhjksawd
hdiutil convert -format UDRW -o ~/xhjksawd/newFile.img $ISOpath
mv ~/xhjksawd/newFile.img.dmg ~/xhjksawd/newFile.img
##### File has been created
echo "----------------------------------------"
echo "Here is a list of your connected devices"
echo "----------------------------------------"
diskutil list | grep -e '/dev\|#:\|0:'
printf "Enter disk you wish to use (Ex. disk1): "
read diskNum
notThis='disk0'
if [[ *"$diskNum"* == *"$notThis"* ]];then
	echo "I will not allow you to do this to the internal drive on your computer!"
	echo "Sorry friend if you REALLY wanna do this then you can do it by hand yourself"
	exit
fi
diskutil unmountDisk $diskNum
sudo dd if=~/xhjksawd/newFile.img of=/dev/r$diskNum bs=1m
echo "Cleaning up..."
rm -rf ~/xhjksawd
