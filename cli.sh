#!/bin/sh

# Installs the necessary setup to use arduino_cli

PORT="/dev/ttyACM0"
BOARD_NAME="Arduino Nano 33 BLE"
FQBN="arduino:mbed:nano33ble"
ARDUINO_CORE="arduino:mbed"

alias acli="/bin/arduino-cli"

acli core install ${ARDUINO_CORE}

acli config init

acli config set library.enable_unsafe_install true

# arduino-cli lib install LIBRARY[@VERSION_NUMBER](S) [flags]
acli lib install "Arduino_TensorFlowLite@2.4.0-ALPHA"

acli lib install --git-url "https://github.com/arpit6232/arduino-library.git"

acli lib install "Arduino_LSM9DS1@1.1.0"

acli lib install "ArduinoBLE@1.2.0"

sudo stty -F /dev/ttyACM0 cs8 9600 ignbrk -brkint -icrnl -imaxbel -opost -onlcr -isig -icanon -iexten -echo -echoe -echok -echoctl -echoke noflsh -ixon -crtscts

sudo chmod 777 /dev/ttyACM0
