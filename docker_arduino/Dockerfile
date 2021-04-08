# AESD Course Project Dockerfile for setting up Arduino IDE and Arduino CLI
# FROM ubuntu:18.04
FROM aarch64/ubuntu:17.04

ENV INSTALL_DIR="\home"
ENV ARDUINO_VERSION="1.8.10"
ENV PORT="/dev/ttyACM0"
ENV BOARD_NAME="Arduino Nano 33 BLE"
ENV FQBN="arduino:mbed:nano33ble"
ENV ARDUINO_CORE="arduino:mbed"
ENV ARDUINO_CODE_DIR="/root/Arduino/libraries/arduino-library/examples/person_detection"
ENV DEV_LOC="/dev/serial/by-id/usb-Arduino_Nano_33_BLE_AD986F55B90290BE-if00"
ENV ARDUINO_IDE_EXE="./$INSTALL_DIR/bin/arduino-cli"


## Reference: https://github.com/cu-ecen-5013/final-project-CalebProvost/blob/docker/Dockerfile
# Install build system's dependencies
RUN apt-get update
RUN apt-get -y upgrade

# Remote Utilities
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    apt-utils \
    software-properties-common \
    gawk \
    git \
    wget \
    git-core \
    subversion \
    screen \
    tmux \
    sudo \
    iputils-ping \
    iproute2 \
    tightvncserver \
    apt-transport-https \
    ca-certificates \
    gpg \
    curl \
    lsb-release

# Build Tools
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    make \
    cmake \
    gcc \
    gcc-multilib \
    g++-multilib \
    gcc-8 \
    g++-8 \
    clang-format \
    clang-tidy \
    cpio \
    diffstat \
    build-essential \
    bmap-tools \
    vim \
    nano \
    bash-completion \
    gnupg \
    tar

# Development Libraries
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libegl1-mesa \
    libsdl1.2-dev \
    libasio-dev \
    libtinyxml2-dev \
    libcppunit-dev \
    libzstd-dev \
    libbenchmark-dev \
    libspdlog-dev \
    liblog4cxx-dev \
    libcunit1-dev \
    libbz2-dev

# Utilities
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    dkms \
    iputils-ping  \
    mesa-utils \
    debianutils \
    pylint3 \
    xterm \
    unzip \
    sysstat \
    texinfo \
    chrpath \
    socat \
    xz-utils  \
    locales \
    fluxbox

# Python Packages
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    python \
    python3 \
    python-rosdep \
    python3-pip \
    python3-pexpect \
    python3-git \
    python3-jinja2 \
    python3-vcstools \
    python3-babeltrace \
    python3-pygraphviz \
    python3-mock \
    python3-nose \
    python3-mypy \
    python3-pytest-mock \
    python3-lttng

# Upgrade Python's package installer
RUN pip3 install -U pip \
    -U colcon-core \
    -U colcon-common-extensions

RUN mkdir -p /etc/udev/rules.d

COPY 99-arduino-101.rules /etc/udev/rules.d/

RUN cd /home

RUN echo "Installing Arduino CLI"

RUN mkdir -p /home/arduino_cli

RUN git clone https://github.com/arpit6232/custom_arduino_cli.git /home/arduino_cli

RUN cp /home/arduino_cli/bin/arduino-cli /home

RUN export PATH="/home/arduino_cli/bin:$PATH" 

RUN echo "Setting up udev rules for Arduino"

# Setup Udev Rules
RUN sudo touch /etc/udev/rules.d/99-arduino-101.rules
RUN sudo echo "# Arduino 101 in DFU Mode \n\n" > /etc/udev/rules.d/99-arduino-101.rules
RUN sudo echo 'SUBSYSTEM=="tty", ENV{ID_REVISION}=="8087", ENV{ID_MODEL_ID}=="0ab6", MODE="0666", ENV{ID_MM_DEVICE_IGNORE}="1", ENV{ID_MM_CANDIDATE}="0"' >> /etc/udev/rules.d/99-arduino-101.rules
RUN sudo echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="8087", ATTR{idProduct}=="0aba", MODE="0666", ENV{ID_MM_DEVICE_IGNORE}="1"' >> /etc/udev/rules.d/99-arduino-101.rules

RUN echo "Moving back to INSTALL_DIR"
RUN cd /home

# Setup the core, library and the cli
RUN echo "Setting up arduino:mbed core and setting up config"
RUN ./home/arduino-cli core install ${ARDUINO_CORE}
RUN ./home/arduino-cli config init
RUN ./home/arduino-cli config set library.enable_unsafe_install true

# Libraries Install
RUN echo "Installing Libraries"
RUN ./home/arduino-cli lib install "Arduino_TensorFlowLite@2.4.0-ALPHA"
RUN ./home/arduino-cli lib install --git-url "https://github.com/arpit6232/arduino-library.git"
RUN ./home/arduino-cli lib install "Arduino_LSM9DS1@1.1.0"
RUN ./home/arduino-cli lib install "ArduinoBLE@1.1.3"

# Compile code
RUN echo "Compiling Person Detection Code"
RUN ./home/arduino-cli compile -b ${FQBN} ${ARDUINO_CODE_DIR} -v

# VOLUME /dev/serial/by-id/usb-Arduino_Nano_33_BLE_AD986F55B90290BE-if00
VOLUME /dev/ttyACM0

# #Upload Code 
# RUN echo "Uploading code to Person Detection Code"
# RUN ./home/arduino-cli upload -b ${FQBN} -p ${PORT} ${ARDUINO_CODE_DIR} -v

CMD [ "sudo", "./home/arduino-cli", "upload", "-b", "arduino:mbed:nano33ble", "-p", "/dev/ttyACM0", "/root/Arduino/libraries/arduino-library/examples/person_detection", "-v"]
