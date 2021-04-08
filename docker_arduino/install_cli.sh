#!/bin/sh

cd INSTALL_DIR
INSTALL_DIR="/home"
ARDUINO_VERSION=1.8.10
PORT="/dev/ttyACM0"
BOARD_NAME="Arduino Nano 33 BLE"
FQBN="arduino:mbed:nano33ble"
ARDUINO_CORE="arduino:mbed"
ARDUINO_IDE_EXE="./$INSTALL_DIR/bin/arduino-cli"

echo "Downloading and Installing Arduino CLI"

# Get the necessary binaries
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh -s 0.17.0
cp INSTALL_DIR/bin/arduino-cli INSTALL_DIR/ardino-cli 

export PATH="/home/bin:$PATH"

echo "Setting up udev rules for Arduino"

# Setup Udev Rules
sudo touch /etc/udev/rules.d/99-arduino-101.rules
sudo echo "# Arduino 101 in DFU Mode \n\n" > /etc/udev/rules.d/99-arduino-101.rules
sudo echo 'SUBSYSTEM=="tty", ENV{ID_REVISION}=="8087", ENV{ID_MODEL_ID}=="0ab6", MODE="0666", ENV{ID_MM_DEVICE_IGNORE}="1", ENV{ID_MM_CANDIDATE}="0"' >> /etc/udev/rules.d/99-arduino-101.rules
sudo echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="8087", ATTR{idProduct}=="0aba", MODE="0666", ENV{ID_MM_DEVICE_IGNORE}="1"' >> /etc/udev/rules.d/99-arduino-101.rules

echo "Moving back to INSTALL_DIR"
cd INSTALL_DIR

# Setup the core, library and the cli
echo "Setting up arduino:mbed core and setting up config"
$ARDUINO_IDE_EXE core install ${ARDUINO_CORE}
$ARDUINO_IDE_EXE config init
$ARDUINO_IDE_EXE config set library.enable_unsafe_install true

# Libraries Install
echo "Installing Libraries"
$ARDUINO_IDE_EXE lib install "Arduino_TensorFlowLite@2.4.0-ALPHA"
$ARDUINO_IDE_EXE lib install --git-url "https://github.com/arpit6232/arduino-library.git"
$ARDUINO_IDE_EXE lib install "Arduino_LSM9DS1@1.1.0"
$ARDUINO_IDE_EXE lib install "ArduinoBLE@1.1.3"

# Compile code
echo "Compiling Person Detection Code"
$ARDUINO_IDE_EXE compile -b ${FQBN} ${ARDUINO_CODE_DIR} -v

# Upload Code
if [[ "$?" -ne 0 ]]
    echo "Arduino Code failed to compile, exiting"
    exit 1
fi

$ARDUINO_IDE_EXE upload -b ${FQBN} -p ${PORT} ${ARDUINO_CODE_DIR} -v
if [[ "$?" -ne 0 ]]
    echo "Arduino Code failed to Upload to ttyACM0, exiting"
    exit 1
fi

# Seal off the connection
$ARDUINO_IDE_EXE board attach serial:///dev/ttyACM0 ${ARDUINO_CODE_DIR}
