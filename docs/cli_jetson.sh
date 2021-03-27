#!/bin/bash

sudo apt-get update -y 
sudo apt-get upgrade -y 
sudo apt-get install -y wget
sudo apt-get install -y tar
sudo apt-get install -y curl


CURR_DIR = $(pwd)

INSTALL_DIR=${HOME}
# Direct Jetson support starts at 1.8.10
ARDUINO_VERSION=1.8.10
# ARDUINO_VERSION=1.8.13

# Download Arduino IDE
wget -N https://downloads.arduino.cc/arduino-$ARDUINO_VERSION-linuxaarch64.tar.xz
tar -C $INSTALL_DIR/ -xvf arduino-${ARDUINO_VERSION}-linuxaarch64.tar.xz
cd $INSTALL_DIR/arduino-${ARDUINO_VERSION}
sudo ./install.sh
./arduino-linux-setup.sh "$USER"
echo "You can delete the tar file if desired: arduino-"${ARDUINO_VERSION}"-linuxaarch64.tar.xz"

uname_n = $(uname -n)

sudo chown ${uname_n} /dev/ttyACM0
sudo chmod a+rw /dev/ttyACM0

cd $INSTALL_DIR

# Download Arduino-CLI
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | BINDIR=. sh

sudo chmod +x arduino-cli

PORT="/dev/ttyACM0"
BOARD_NAME="Arduino Nano 33 BLE"
FQBN="arduino:mbed:nano33ble"
ARDUINO_CORE="arduino:mbed"
# TEST_CAMERA_DIR="${INSTALL_DIR}/Arduino/libraries/arduino-library/examples/test_camera"
TEST_CAMERA_DIR="${INSTALL_DIR}/Arduino/libraries/arduino-library/examples/test_camera_v2"


./arduino-cli core install ${ARDUINO_CORE}

./arduino-cli config init

./arduino-cli config set library.enable_unsafe_install true

# arduino-cli lib install LIBRARY[@VERSION_NUMBER](S) [flags]
./arduino-cli lib install "Arduino_TensorFlowLite@2.4.0-ALPHA"

./arduino-cli lib install --git-url "https://github.com/tinyMLx/arduino-library.git"

./arduino-cli lib install "Arduino_LSM9DS1@1.1.0"

./arduino-cli lib install "ArduinoBLE@1.1.3"

./arduino-cli compile -b ${FQBN} ${TEST_CAMERA_DIR} -v

sudo ./arduino-cli upload -b ${FQBN} -p ${PORT} ${TEST_CAMERA_DIR} -v

sudo ./arduino-cli board attach serial:///dev/ttyACM0 ${TEST_CAMERA_DIR}

# sudo ./arduino-cli compile --upload ${TEST_CAMERA_DIR} -v



# Setup USB to store data 
sudo stty -F /dev/ttyACM0 raw 115200
cat /dev/ttyACM0 > raw_points.txt
