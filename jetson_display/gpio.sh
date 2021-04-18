#!/bin/sh 

# Basch Script ot initialize GPIO

echo 79 > /sys/class/gpio/export
echo 0 > /sys/class/gpio/gpio79/value

if [ [ -z "$1" ] ]; 
then 
	echo " INVALID NUMBER OF ARGUMENTS SUPPLIED AT RUNTIME"
	echo " * First Argument should be Directory Path "
	exit 1
fi

# if 1st argument is 1, turn on the LED
if [[ "$1" -eq 1 ]] 
then
	echo 1 > /sys/class/gpio/gpio79/value
	exit 0

# Check if the 2nd Argument is not Empty
elif [[ "$1" -eq 0 ]] 
then	
	echo 0 > /sys/class/gpio/gpio79/value
	exit 0	
fi

