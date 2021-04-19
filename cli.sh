#!/bin/sh

# Installs the necessary setup to use arduino_cli

PORT="/dev/ttyACM0"
BOARD_NAME="Arduino Nano 33 BLE"
FQBN="arduino:mbed:nano33ble"
ARDUINO_CORE="arduino:mbed"

alias acli="/usr/bin/arduino-cli"

/usr/bin/arduino-cli core install ${ARDUINO_CORE}

/usr/bin/arduino-cli config init

/usr/bin/arduino-cli config set library.enable_unsafe_install true

# arduino-cli lib install LIBRARY[@VERSION_NUMBER](S) [flags]
/usr/bin/arduino-cli lib install "Arduino_TensorFlowLite@2.4.0-ALPHA"

/usr/bin/arduino-cli lib install --git-url "https://github.com/arpit6232/arduino-library.git"

/usr/bin/arduino-cli lib install "Arduino_LSM9DS1@1.1.0"

/usr/bin/arduino-cli lib install "ArduinoBLE@1.2.0"

sudo stty -F /dev/ttyACM0 cs8 9600 ignbrk -brkint -icrnl -imaxbel -opost -onlcr -isig -icanon -iexten -echo -echoe -echok -echoctl -echoke noflsh -ixon -crtscts

sudo chmod 777 /dev/ttyACM0

PERSON_DETECTION_DIR="/home/root/Arduino/libraries/arduino-library/examples/person_detection"

/usr/bin/arduino-cli compile -b ${FQBN} ${PERSON_DETECTION_DIR} 

/usr/bin/arduino-cli upload -b ${FQBN} -p ${PORT} ${PERSON_DETECTION_DIR} 
