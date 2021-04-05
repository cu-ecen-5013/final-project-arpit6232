---
title: Jetson Image
---

# Build Jetson Image 

## Install Jetson Binaries 
- Install SDK Manager
```
wget https://developer.nvidia.com/nvsdk-manager $HOME/Downloads
```

- Setup the Development Environment 
    - Create an account and log into the SDK Manager 
    - From the Product Category panel, select Jetson. 
    - From the Hardware Configuration panel, select the host machine and target hardware. 
    - ![Step 1](img/jetson_1.png)
    - Select Target operating system as "Linux JetPack 4.5.1"
    - Select Target hardware as Jetson Nano 2GB developer kit version / Jetson Nano kit version. 
    - Click Continue to proceed to the next step.

- Step 2: Review Components and Accept Licenses
    - If you want SDK Manager to download all setup files to a location other than the default path, go to the Download & Install Options located at the bottom of the screen, then select the path you wish to use. 
    - ONLY DOWNLOAD THE FILES, NO INSTALLATION IS NEEDED 
    - ![Step 2](img/jetson_2.png)
    - Select Continue to proceed to the next step. 

- Step 3: Installation
    - Before the installation begins, SDK Manager prompts you to enter your sudo password. (This should not be needed unless you have selected Install in the previous step). 
    - ![Step 3](img/jetson_3.png)
    - The display shows the progress of the download and installation of the software. 
    - At the top, you can toggle between the Details and Terminal tabs. The Terminal tab shows detailed information about the download and installation, with any errors highlighted.
    - The necessary binaries should now be installed under $HOME/Downloads/nvidia/skdm_downloads


## Install the dependencies for OE4T Jetson meta-tegra and tegra-demo-distro 
- Install the necessary dependencies 
```
sudo apt-get install -y gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev pylint3 xterm
sudo apt install -y gcc make build-essential gcc-multilib dkms mesa-utils
sudo apt install -y gcc-8 
sudo apt install -y g++-8 -y
sudo apt-get install -y libnvidia-container1
sudo apt-get install -y libnvidia-container-tools
sudo apt install -y build-essential cmake git python3-colcon-common-extensions python3-pip python-rosdep python3-vcstool wget
sudo apt-get install -y docker-ce docker-ce-cli containerd.io 
sudo apt install -y --no-install-recommends libasio-dev libtinyxml2-dev
sudo apt-get install -y libcppunit-dev
sudo apt-get install -y python3-babeltrace
sudo apt-get install -y python3-pygraphviz
sudo apt-get install -y clang-format
sudo apt-get install -y python3-mock
sudo apt-get install -y libzstd-dev
sudo apt-get install -y libbenchmark-dev
sudo apt-get install -y python3-nose
sudo apt-get install -y libspdlog-dev
sudo apt-get install -y clang-tidy
sudo apt-get install -y liblog4cxx-dev
sudo apt-get install -y libcunit1-dev
sudo apt-get install -y python3-mypy
sudo apt-get install -y python3-pytest-mock
sudo apt-get install -y python3-lttng
```

- Yocto build can have very specific dependencies follow https://github.com/OE4T/meta-tegra for details. 

## Install Yocto reposities and dependencies for Jetson NANO only (Scroll below for Jetson-Nano 2GB)

```
###############################################
## IMPORTANT STEP 
# Nvidia sets up major components as binaries 
##
###############################################
```

- Download the meta-tegra layer 
```
git clone git@github.com:OE4T/meta-tegra.git
```

- Download the tegra-demo-distro
```
git clone git@github.com:OE4T/tegra-demo-distro.git
```

- Get into the directory 
```
cd tegra-demo-distro/
```

- Select the necessary directory 
```
# Branches Currently available under git clone git@github.com:OE4T/tegra-demo-distro.git
# master - never stable. You probably don't want to use this one unless you know you want to work on the bleeding edge.
# gatesgarth - tegrademo-mender support is not yet complete or fully tested on this branch. Use this branch for experimental Nano-2GB support.
# dunfell-l4t-r32.4.3 - Current stable branch with support for all platforms with the exception of Nano-2GB.
```

```
git checkout dunfell-l4t-r32.4.3
```

- Submodules pulls yocto dependencies
```
git submodule update --init
```

- Use . ./setup-env --help to setup the necessary distro and select the machine intended to be built for 
    - . ./setup-env --machine jetson-nano-qspi-sd

- Begin bitbake 
```
# -----------------| -----------------------
# Image list 
# demo-image-base 	    Basic image with no graphics
# demo-image-egl 	    Base with DRM/EGL graphics, no window manager
# demo-image-sato 	    X11 image with Sato UI
# demo-image-weston 	Wayland with Weston compositor
# demo-image-full 	    Sato image plus nvidia-docker, openCV, multimedia API samples
```

```
bitbake demo-image-full
```
- This step would take around 2-3 hours of build time depending on internet speed.

## Install Yocto reposities and dependencies for Jetson-Nano 2GB

```
###############################################
## IMPORTANT STEP 
# Nvidia sets up major components as binaries 
##
###############################################
```

- Download the meta-tegra layer 
```
git clone git@github.com:OE4T/meta-tegra.git
```

- Download the tegra-demo-distro
```
git clone git@github.com:OE4T/tegra-demo-distro.git
```

- Get into the directory 
```
cd tegra-demo-distro/
```

- Select the necessary directory 
```
# Branches Currently available under git clone git@github.com:OE4T/tegra-demo-distro.git
# master - never stable. You probably don't want to use this one unless you know you want to work on the bleeding edge.
# gatesgarth - tegrademo-mender support is not yet complete or fully tested on this branch. Use this branch for experimental Nano-2GB support.
# dunfell-l4t-r32.4.3 - Current stable branch with support for all platforms with the exception of Nano-2GB.
```

```
git checkout gatesgarth
```

- Submodules pulls yocto dependencies
```
git submodule update --init
```

- Use . ./setup-env --help to setup the necessary distro and select the machine intended to be built for 
    - . ./setup-env --machine jetson-nano-2gb-devkit

- Begin bitbake 
```
# -----------------| -----------------------
# Image list 
# demo-image-base 	    Basic image with no graphics
# demo-image-egl 	    Base with DRM/EGL graphics, no window manager
# demo-image-sato 	    X11 image with Sato UI
# demo-image-weston 	Wayland with Weston compositor
# demo-image-full 	    Sato image plus nvidia-docker, openCV, multimedia API samples
```

```
bitbake demo-image-full
```

- This step would take around 2-3 hours of build time depending on internet speed.

## Image Location 
- Image should be located at ```tegra-demo-distro/build/tmp/deploy/images```
- Follow https://github.com/OE4T/meta-tegra/wiki/Flashing-the-Jetson-Dev-Kit for more details. 
