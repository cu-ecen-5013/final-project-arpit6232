#!/bin/sh 

# Basch Script ot initialize GPIO

sudo groupadd gpio
sudo usermod -aG gpio root
su root
sudo chgrp gpio /sys/class/gpio/export
sudo chgrp gpio /sys/class/gpio/unexport
sudo chmod 775 /sys/class/gpio/export
sudo chmod 775 /sys/class/gpio/unexport

echo "79" > /sys/class/gpio/export
chgrp -HR /sys/class/gpio/gpio79
chmod -R 775 /sys/class/gpio/gpio79

echo "out" > /sys/class/gpio/gpio79/direction

if [[ "$#" -ne 1 ]]  
then 
	echo " INVALID NUMBER OF ARGUMENTS SUPPLIED AT RUNTIME"
	echo " * First Argument should be Directory Path "
	exit 1
fi

# if 1st argument is 1, turn on the LED
if [[ "$1" -eq 1 ]] 
then
	sudo echo 1 > /sys/class/gpio/gpio79/value
	exit 0

# Check if the 2nd Argument is not Empty
elif [[ "$1" -eq 0 ]] 
then	
	sudo echo 0 > /sys/class/gpio/gpio79/value
	exit 0	
fi


echo "79" > /sys/class/gpio/unexport
