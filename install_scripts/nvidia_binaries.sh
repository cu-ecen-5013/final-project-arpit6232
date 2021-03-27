#!/bin/bash


###############################################
## IMPORTANT STEP 
# The binaries here are preliminary for 
# Jetson_Tegra_demo_build.sh
# and should be located at path : $HOME/Downloads/
##
###############################################

if [[ $# -ne 1 ]]
then 
	echo " INVALID NUMBER OF ARGUMENTS SUPPLIED"
	echo " * First Argument should specify if 4GB(Default) or 2GB Version of Jetson "
	exit 1
fi

# Check if the first argument is empty or is not a directory
if [[ "$1" = "" ]] || ! [[ -d "$1" ]]
then
    DEVICE="4GB"
fi		

if [[ DEVICE -eq "4GB" ]]
then 
    wget -P "$HOME/Downloads" -q -O tmp.zip "www.xyz.com" && unzip tmp.zip && rm tmp.zip
fi

if [[ DEVICE -eq "2GB" ]]
then 
    wget -P "$HOME/Downloads" -q -O tmp.zip "www.xyz.com" && unzip tmp.zip && rm tmp.zip
fi
