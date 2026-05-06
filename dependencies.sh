#!/bin/bash

# build apt installs
apt-get update
apt-get install -y build-essential
apt-get install -y bzip2 libbz2-dev
apt-get install -y cmake
apt-get install -y coreutils
apt-get install -y git
apt-get install -y libboost-dev
apt-get install -y libboost-filesystem-dev
apt-get install -y libboost-program-options-dev
apt-get install -y libboost-regex-dev
apt-get install -y libboost-thread-dev
apt-get install -y libfmt-dev
apt-get install -y libgpgme-dev
apt-get install -y libgtest-dev
apt-get install -y liblog4cxx-dev
apt-get install -y liblz4-dev lz4
apt-get install -y libpoco-dev
apt-get install -y libtinyxml2-dev
apt-get install -y libeigen3-dev
apt-get install -y libpcl-dev
apt-get install -y mawk
apt-get install -y python-is-python3
apt-get install -y python3
apt-get install -y python3-dateutil
apt-get install -y python3-dev
apt-get install -y python3-docutils
apt-get install -y python3-empy
apt-get install -y python3-pyparsing
apt-get install -y python3-setuptools
apt-get install -y python3-yaml

# runtime
apt-get install -y python3-defusedxml
apt-get install -y python3-distro
apt-get install -y python3-netifaces

apt-get install -y python3-pycryptodome
apt-get install -y python3-gnupg

# TODO(lucasw) get this from source later
apt-get install -y python3-rosunit

# Added by Lindsay
apt-get install -y libboost-python-dev
apt-get install -y libyaml-cpp-dev
apt-get install -y libbondcpp-dev
apt-get install -y libcgal-dev

# Optional: rqt_bag dependencies
if [ "${WITH_RQT_BAG}" = "1" ]; then
  apt-get install -y python3-pyqt5
  apt-get install -y pyqt5-dev
  apt-get install -y pyqt5-dev-tools
  apt-get install -y python3-sip-dev
  apt-get install -y qtbase5-dev
  apt-get install -y libtinyxml-dev
  # rqt_bag_plugins (image + plot plugins inside rqt_bag)
  apt-get install -y python3-cairo
  apt-get install -y python3-pil
  apt-get install -y python3-matplotlib
  apt-get install -y python3-numpy
  # Pillow 10 (shipped with Ubuntu 24.04) dropped PyQt5/PySide2 support from
  # PIL.ImageQt — only PyQt6 and PySide6 are tried. rqt_bag's image plugin
  # imports `from PIL.ImageQt import ImageQt` against PyQt5, which fails.
  # Downgrade Pillow to a version that still supports PyQt5.
  apt-get install -y python3-pip
  pip3 install --break-system-packages 'Pillow<10'
fi

# Optional: robot_state_publisher dependencies
if [ "${WITH_ROBOT_STATE_PUBLISHER}" = "1" ]; then
  apt-get install -y liburdfdom-dev
  apt-get install -y liburdfdom-headers-dev
  apt-get install -y libcurl4-openssl-dev
fi

# Optional: rviz dependencies
if [ "${WITH_RVIZ}" = "1" ]; then
  apt-get install -y libogre-1.12-dev
  apt-get install -y libgl1-mesa-dev
  apt-get install -y libassimp-dev
  apt-get install -y libcurl4-openssl-dev
  apt-get install -y liburdfdom-dev
  apt-get install -y liburdfdom-headers-dev
  apt-get install -y libtinyxml-dev
  apt-get install -y python3-pykdl
  # Qt5 dependencies (may already be installed by WITH_RQT_BAG)
  apt-get install -y python3-pyqt5
  apt-get install -y pyqt5-dev
  apt-get install -y pyqt5-dev-tools
  apt-get install -y python3-sip-dev
  apt-get install -y qtbase5-dev
fi
