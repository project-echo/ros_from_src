# ros_from_src

To build ros entirely from source without using a PPA (or even the debian ros packages): 

#### <b> NOTE: </b> Following instructions are tested on Ubuntu 2404

## Clone repo and install dependencies
    git clone https://github.com/mahirgulzarstarship/ros_from_src.git
    cd ros_from_src
    mkdir build
    cd build
    ../git_clone.sh
    # (take look at this script before running as sudo)
    sudo ../dependencies.sh

### Install orocos_kdl 

    sudo mkdir -p /opt/orocos/noetic
    sudo chwown <youruser> /opt/orocos/noetic

    git clone https://github.com/orocos/orocos_kinematics_dynamics.git
    cd orocos_kinematics_dynamics/orocos_kdl 

    mkdir build
    cd build

    cmake .. -DCMAKE_INSTALL_PREFIX=/opt/orocos/noetic
    make -j$(nproc)
    sudo make install

    sudo chown root /opt/orocos/noetic


## Build

    cd ros_from_src/build

    # The build.sh file will also install to /opt/ros/noetic
    sudo mkdir /opt/ros/noetic
    sudo chown <youruser> /opt/ros/noetic
    ../build.sh
    sudo chown root /opt/ros/noetic

## Export variables and source

    # Make sure to check the ros_from_src path before exporting
    export ROS_BUILD_DIR=$HOME/ros_from_src/build/ #CHANGE to your ros_from_src/build folder
    export CMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH:$ROS_BUILD_DIR/ros/lib/cache
    export PATH=$ROS_BUILD_DIR/ros/local/bin:$PATH
    export PYTHONPATH=$PYTHONPATH:$ROS_BUILD_DIR/ros/local/lib/python3.12/dist-packages/
    source $ROS_BUILD_DIR/catkin_ws/devel/setup.bash


If you have problems compiling packages that use pcl: build processes complaining they depend on `usb-1.0` but can't find it, apply this patch to one of pcl's included cmake files:

```
--- old/Findlibusb.cmake        2025-05-25 14:55:58.089547900 +0300
+++ /usr/lib/x86_64-linux-gnu/cmake/pcl/Modules/Findlibusb.cmake        2025-05-25 14:50:09.888244937 +0300
@@ -69,5 +69,5 @@
 if(libusb_FOUND)
   add_library(libusb::libusb UNKNOWN IMPORTED)
   set_target_properties(libusb::libusb PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${libusb_INCLUDE_DIR}")
-  set_target_properties(libusb::libusb PROPERTIES IMPORTED_LOCATION "${libusb_LIBRARIES}")
+  set_target_properties(libusb::libusb PROPERTIES IMPORTED_LOCATION "${PC_libusb_LINK_LIBRARIES}")
 endif()
```
