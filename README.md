# ECEN 5713 Final Project Repository 

### Repository Owner - Arpit Savarkar 

This Repository Contains the Tensorflow Code for Deploying Tiny Machine learning over Jetson Nano and Arduino BLE 33 to react to a camera feed to detect to a person. 

## Repository Overview 
- [Final Project Overview Wiki Page](https://github.com/AESD-Course-Project/AESD-Course-Project.github.io/wiki/Project-Overview)

- All issues are tracked here : https://github.com/AESD-Course-Project/AESD-Course-Project.github.io/issues

- Issues in this repository are duplicated. Please use this link only tracking on [issues](https://github.com/AESD-Course-Project/AESD-Course-Project.github.io/issues)

## Code source download over Docker (Takes 5-6 hours for Yocto to build)
```
git clone https://github.com/CalebProvost/dockter-l4t.git
docker pull calebprovost/dockter-l4t:sdk_installed
docker run -it -v $PWD:/home/user/build --name dl4t calebprovost/dockter-l4t:sdk_installed bash
git clone https://github.com/OE4T/tegra-demo-distro.git && cd tegra-demo-distro/
git submodule update --init --recursive
git clone https://github.com/cu-ecen-5013/final-project-CalebProvost.git --branch=yocto-layer --single-branch layers/meta-final-project
unset DISTRO && unset MACHINE
. ./setup-env --machine jetson-nano-2gb-devkit --distro final-project
bitbake final-project-image
```

## Project Contribution (Summary)
1. Computer Vision - Machine Learning - TinyML 
    - [Custom Library](https://github.com/arpit6232/arduino-library)
    - [Nueral Network for Micro-controllers](https://github.com/arpit6232/visualwakeup_aesd)
    - [API, setup and Response](https://github.com/AESD-Course-Project/AESD-Course-Project.github.io/issues/24)
    - [Dockerize building on Host](https://hub.docker.com/repository/docker/arpit6232/arduino_cli)
    - [Arduino-cli for Person Detection on Jetson Nano](https://github.com/cu-ecen-5013/final-project-arpit6232/blob/0d40fbcefad26e7cc435347949e6527a70a7e3b1/cli.sh)

2. Yocto Integration for OE4T tegra 
    - Forum Discussion for analysis
        - [Board Partition]https://github.com/OE4T/meta-tegra/discussions/661
        - [Camera Module](https://github.com/OE4T/meta-tegra/discussions/653)
        - [arduino-cli test for ARM64](https://github.com/arduino/ArduinoCore-mbed/issues/176)
    - Additional Yocto receipes 
        - [Yocto receipes with systemd init]https://github.com/cu-ecen-5013/final-project-CalebProvost/tree/yocto-layer

3. [Arpit Savarkar's Final Project Video](https://github.com/AESD-Course-Project/AESD-Course-Project.github.io/wiki/Arpit-Savarkar's-Final-Project-Video)


## Sprint 4 - Final Project Demonstration 

### Code and Future goal setup

1. [Integrate systemd Init script for the arduino cli over Yocto](https://github.com/cu-ecen-5013/final-project-CalebProvost/commit/1638714ecaf2a8d41b95062672a6b2827731ebb1)
2. Compile, clean code and QA Docker file for final submission docker file.
3. Project Demonstration and Setup.
4. Future Goal projects
    - https://github.com/cu-ecen-5013/final-project-CalebProvost/tree/yocto_layer_fix_With_i2c
    - https://github.com/cu-ecen-5013/final-project-arpit6232/tree/main/jetson_display

### Final Project Demo 
- [Arpit Savarkar's Final Project Video](https://github.com/AESD-Course-Project/AESD-Course-Project.github.io/wiki/Arpit-Savarkar's-Final-Project-Video)

## Sprint 3

### Code and Linked Issues
1. State Machine and API Development and response for Arduino BLE 33 Sense : https://github.com/AESD-Course-Project/AESD-Course-Project.github.io/issues/24
2. Develop and Test Driver for I2C Based 4 Character 7 Segment Display and GPIO based LED functioning : https://github.com/AESD-Course-Project/AESD-Course-Project.github.io/issues/23
3. Board Partition Bring Up and Forum Communication : https://github.com/AESD-Course-Project/AESD-Course-Project.github.io/issues/22

### Documentation 
1. [Wiring Diagram and Setup for GPIO](https://github.com/AESD-Course-Project/AESD-Course-Project.github.io/blob/master/src/GPIO_setup.md)

## Sprint 2 

### Code
1. Dockerize Arduino Build Environment : https://github.com/cu-ecen-5013/final-project-arpit6232/tree/main/docker_arduino
2. Integrate Camera for gstreamer 
    - https://github.com/OE4T/meta-tegra/discussions/653#discussioncomment-582858
    - https://forums.developer.nvidia.com/t/unable-to-detect-logitech-c270-on-jp-4-5-1-on-jetson-nano/174734/2
3. Create driver for vitualwifi for cfg80211 : https://github.com/cu-ecen-5013/final-project-arpit6232/tree/main/wifi_driver

### Documentation
1. [Synchronize Time on Jetson](https://github.com/cu-ecen-5013/final-project-arpit6232/blob/reset_jetson_time/date-sync.md)

### Issues worked on :
1. https://github.com/AESD-Course-Project/AESD-Course-Project.github.io/issues/12
2. https://github.com/AESD-Course-Project/AESD-Course-Project.github.io/issues/11

## Sprint 1 

### Code
1. Port Tensorflow code : https://github.com/arpit6232/visualwakeup_aesd
2. Create Arduino Library : https://github.com/arpit6232/arduino-library

### Documentation
1. [Arduino Interface for Jetson](docs/arduino_setup.md)
2. [Jetson Setup for Jetson Nano](install_jetson_yocto.md)

### Comments 
Currently this repository should hold all the independent goals are separate repositories as much of the code is based on development version of other libraries. And involves testing and development. 


### Comments 
Currently this repository should hold all the independent goals as separate repositories/folders as much of the code is based on development version of other libraries. And involves testing and development. 

### TEAM MEMBERS 
- Arpit Savarkar 
- Caleb Provost 
- Zach Turner 
