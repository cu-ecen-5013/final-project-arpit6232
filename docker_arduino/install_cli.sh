#!/bin/bash

cd $HOME
INSTALL_DIR=${HOME}
ARDUINO_VERSION=1.8.10
PORT="/dev/ttyACM0"
BOARD_NAME="Arduino Nano 33 BLE"
FQBN="arduino:mbed:nano33ble"
ARDUINO_CORE="arduino:mbed"

echo "Downloading and Installing Arduino CLI"

# Get the necessary binaries
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh -s 0.17.0
mv $HOME/bin/arduino-cli $HOME/ardino-cli 

echo "Setting up udev rules for Arduino"

# Setup Udev Rules
touch /etc/udev/rules.d/99-arduino-101.rules
echo "# Arduino 101 in DFU Mode \n\n" > /etc/udev/rules.d/99-arduino-101.rules
echo 'SUBSYSTEM=="tty", ENV{ID_REVISION}=="8087", ENV{ID_MODEL_ID}=="0ab6", MODE="0666", ENV{ID_MM_DEVICE_IGNORE}="1", ENV{ID_MM_CANDIDATE}="0"' >> /etc/udev/rules.d/99-arduino-101.rules
echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="8087", ATTR{idProduct}=="0aba", MODE="0666", ENV{ID_MM_DEVICE_IGNORE}="1"' >> /etc/udev/rules.d/99-arduino-101.rules

echo "Moving back to $HOME"
cd $HOME

# Setup the core, library and the cli
echo "Setting up arduino:mbed core and setting up config"
./arduino-cli core install ${ARDUINO_CORE}
./arduino-cli config init
./arduino-cli config set library.enable_unsafe_install true

# Libraries Install
echo "Installing Libraries"
./arduino-cli lib install "Arduino_TensorFlowLite@2.4.0-ALPHA"
./arduino-cli lib install --git-url "https://github.com/arpit6232/arduino-library.git"
./arduino-cli lib install "Arduino_LSM9DS1@1.1.0"
./arduino-cli lib install "ArduinoBLE@1.1.3"

# Compile code
echo "Compiling Person Detection Code"
./arduino-cli compile -b ${FQBN} ${ARDUINO_CODE_DIR} -v

# Upload Code
if [[ "$?" -ne 0 ]]
    echo "Arduino Code failed to compile, exiting"
    exit 1
fi

./arduino-cli upload -b ${FQBN} -p ${PORT} ${ARDUINO_CODE_DIR} -v
if [[ "$?" -ne 0 ]]
    echo "Arduino Code failed to Upload to ttyACM0, exiting"
    exit 1
fi

# Seal off the connection
./arduino-cli board attach serial:///dev/ttyACM0 ${ARDUINO_CODE_DIR}
