# ECEN 5713 Final Project Repository 

### Repository Owner - Arpit Savarkar 

This Repository Contains the Tensorflow Code for Deploying Tiny Machine learning over Jetson Nano and Arduino BLE 33 to react to a camera feed to detect to a person. 

## Repository Overview 
- [Final Project Overview Wiki Page](https://github.com/AESD-Course-Project/AESD-Course-Project.github.io/wiki/Project-Overview)

- All issues are tracked here : https://github.com/AESD-Course-Project/AESD-Course-Project.github.io/issues

- Issues in this repository are duplicated. Please use this link only tracking on [issues](https://github.com/AESD-Course-Project/AESD-Course-Project.github.io/issues)


## Issues are not tracked in this repository  

## Issues are tracked here: https://github.com/AESD-Course-Project/AESD-Course-Project.github.io/issues

## Project Schedule : https://github.com/AESD-Course-Project/AESD-Course-Project.github.io/wiki/Project-Schedule


## Sprint 3

### Code and Linked Issues
1. State Machine and API Development and response for Arduino BLE 33 Sense : https://github.com/AESD-Course-Project/AESD-Course-Project.github.io/issues/24
2. Develop and Test Driver for I2C Based 4 Character 7 Segment Display and GPIO based LED functioning : https://github.com/AESD-Course-Project/AESD-Course-Project.github.io/issues/24
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
