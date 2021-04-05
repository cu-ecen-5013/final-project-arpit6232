# AESD Course Project Dockerfile for setting up Arduino IDE and Arduino CLI
FROM ubuntu:18.04

ENV INSTALL_DIR=$HOME
ENV ARDUINO_VERSION="1.8.10"
ENV PORT="/dev/ttyACM0"
ENV BOARD_NAME="Arduino Nano 33 BLE"
ENV FQBN="arduino:mbed:nano33ble"
ENV ARDUINO_CORE="arduino:mbed"
ENV ARDUINO_CODE_DIR="$HOME/Arduino/libraries/arduino-library/examples/person_detection"
ENV DEV_LOC="/dev/serial/by-id/usb-Arduino_Nano_33_BLE_AD986F55B90290BE-if00"

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

RUN cd $HOME

RUN echo "Installing Arduino CLI"

# Script to Begin the Yocto Build for Jetson Image
COPY install_cli.sh $HOME

RUN chmod +x $HOME/install_cli.sh

CMD [ "bash", "-c", "./$HOME/install_cli.sh" ]
