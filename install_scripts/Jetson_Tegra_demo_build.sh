#!/bin/bash


###############################################
## IMPORTANT STEP 
# Nvidia sets up major components as binaries 
# Look at nvidia_binaries.sh
##
###############################################

# ##
# Download the meta-tegra
git clone git@github.com:OE4T/meta-tegra.git

# ##
# Download the tegra-demo-distro
git clone git@github.com:OE4T/tegra-demo-distro.git

# ##
# Get into the directory 
cd tegra-demo-distro/

# ##
# Branches Currently available under git clone git@github.com:OE4T/tegra-demo-distro.git
# master - never stable. You probably don't want to use this one unless you know you want to work on the bleeding edge.
# gatesgarth - tegrademo-mender support is not yet complete or fully tested on this branch. Use this branch for experimental Nano-2GB support.
# dunfell-l4t-r32.4.3 - Current stable branch with support for all platforms with the exception of Nano-2GB.
git checkout dunfell-l4t-r32.4.3

# ##
# Submodules pulls yocto dependencies 
git submodule update --init

# ##
# Usage: . ./setup-env --machine <MACHINE> [<options>] [<BUILDDIR>]
# Usage: . ./setup-env [<BUILDDIR>]

# Options:
#     -h, --help         Print this usage message
#     -m, --machine      Set the MACHINE name in the build configuratino
#     -d, --distro       Set the DISTRO name in the build configuration (default 'tegrademo')
#     -c, --color        Colorize the output; can be 'never', 'always',
#                              or 'auto' (default 'auto')

# Arguments:
#     BUILDDIR           Location of BUILDDIR (default 'build')

# The first usage is for creating a new build directory. In this case, the
# script creates the build directory <BUILDDIR>, configures it for the
# specified <MACHINE> and <DISTRO>, and prepares the calling shell for
# running bitbake on the build directory.

# The second usage is for using an existing build directory. In this case,
# the script prepares the calling shell for running bitbake on the build
# directory <BUILDDIR>. The build directory configuration is unchanged.

# Available distros:
# 	tegrademo
# 	tegrademo-mender
# Available machines:
# 	jetson-nano-emmc
# 	jetson-nano-emmc-cot
# 	jetson-nano-qspi-sd  <-- USE THIS
# 	jetson-nano-qspi-sd-cot

# Environment variables:
#     NVIDIA_DEVNET_MIRROR     URL or pathname of NVIDIA SDK Manager downloads.
#                              Default: $HOME/Downloads/nvidia/sdkm_downloads

# Examples:
# - To create a new Yocto build directory:
#   $ . setup-env --machine jetson-tx2 --distro testdistro build-testdistro
# - To use an existing Yocto build directory:
#   $ . setup-env build-testdistro

# Sets up the configuration file and cd into build
. ./setup-env --machine jetson-nano-qspi-sd

# ##
# Begin bitbake
# -----------------| -----------------------
# Image list 
# demo-image-base 	    Basic image with no graphics
# demo-image-egl 	    Base with DRM/EGL graphics, no window manager
# demo-image-sato 	    X11 image with Sato UI
# demo-image-weston 	Wayland with Weston compositor
# demo-image-full 	    Sato image plus nvidia-docker, openCV, multimedia API samples
bitbake demo-image-full
