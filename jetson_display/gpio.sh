#!/bin/sh 

# Bash Script to initialize GPIO

echo 79 > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio79/direction

if [[ "$#" -ne 1 ]]  
then 
	echo " INVALID NUMBER OF ARGUMENTS SUPPLIED AT RUNTIME"
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

echo "79" > /sys/class/gpio/unexport
