#!/bin/bash
# TODO(lucasw) replace the below with submodules
# export PATH=$PATH:/usr/local/bin
SRC=`pwd`/src
echo $SRC
mkdir $SRC -p
WS=`pwd`/catkin_ws/src
echo $WS
mkdir $WS -p

# TODO(lucasw) replace these git clones with vcs
# packages that need to be cmake installed, and are ros packages in a catkin workspace
cd $WS
git clone https://github.com/ros/catkin
git clone https://github.com/ros/console_bridge
git clone https://github.com/ros/cmake_modules
git clone https://github.com/ros-o/class_loader
git clone https://github.com/ros/rospack
git clone https://github.com/ros/genmsg

# ros packages, regular catkin build only for these
git clone https://github.com/ros/ros_comm
git clone https://github.com/ros/roscpp_core
git clone https://github.com/ros/ros_comm_msgs
git clone https://github.com/ros/message_generation
git clone https://github.com/ros/gencpp
git clone https://github.com/jsk-ros-pkg/geneus
git clone https://github.com/RethinkRobotics-opensource/gennodejs
git clone https://github.com/ros/genlisp
git clone https://github.com/ros/genpy
git clone https://github.com/ros/std_msgs
git clone https://github.com/ros/message_runtime
git clone https://github.com/ros-o/pluginlib
git clone https://github.com/ros/ros

# Added by Lindsay
git clone https://github.com/ros-perception/image_common --branch noetic-devel
git clone https://github.com/ros/common_msgs
git clone https://github.com/ros/nodelet_core
git clone https://github.com/ros/bond_core --branch noetic-devel
git clone https://github.com/ros/dynamic_reconfigure
git clone https://github.com/ros-perception/perception_pcl --branch melodic-devel
sed -i 's/CMAKE_CXX_STANDARD 14/CMAKE_CXX_STANDARD 17/' perception_pcl/pcl_ros/CMakeLists.txt
git clone https://github.com/ros-perception/pcl_msgs --branch noetic-devel
git clone https://github.com/ros/geometry
touch geometry/kdl_conversions/CATKIN_IGNORE
touch geometry/tf_conversions/CATKIN_IGNORE
git clone https://github.com/ros/angles --branch noetic-devel
git clone https://github.com/ros/geometry2 --branch noetic-devel
touch geometry2/tf2_bullet/CATKIN_IGNORE
if [ "${WITH_RVIZ}" != "1" ]; then
  touch geometry2/tf2_geometry_msgs/CATKIN_IGNORE
fi
touch geometry2/test_tf2/CATKIN_IGNORE
git clone https://github.com/ros/actionlib

ROSCONSOLE1=${ROSCONSOLE:-https://github.com/ros-o/rosconsole}
git clone $ROSCONSOLE1

# pure python
cd $SRC
git clone https://github.com/ros-infrastructure/catkin_pkg
git clone https://github.com/osrf/osrf_pycommon
git clone https://github.com/catkin/catkin_tools

# cmake installs
git clone https://github.com/ros-o/ros_environment


# runtime
git clone https://github.com/ros-infrastructure/rospkg
git clone https://github.com/ros-infrastructure/rosdistro
git clone https://github.com/lucasw/rosdep --branch disable_root_etc_ros

# Optional: rqt_bag and its dependencies
if [ "${WITH_RQT_BAG}" = "1" ]; then
  cd $WS
  git clone https://github.com/ros-visualization/python_qt_binding --branch noetic-devel
  git clone https://github.com/ros-visualization/qt_gui_core --branch noetic-devel
  git clone https://github.com/ros-visualization/rqt --branch noetic-devel
  git clone https://github.com/ros-visualization/rqt_bag --branch noetic-devel
fi

# Optional: robot_state_publisher and its dependencies
if [ "${WITH_ROBOT_STATE_PUBLISHER}" = "1" ]; then
  cd $WS
  git clone https://github.com/ros/resource_retriever --branch noetic-devel
  git clone https://github.com/ros/rosconsole_bridge --branch noetic-devel
  git clone https://github.com/ros/urdf --branch noetic-devel
  git clone https://github.com/ros/kdl_parser --branch noetic-devel
  git clone https://github.com/ros/robot_state_publisher --branch noetic-devel
  git clone https://github.com/ros/joint_state_publisher --branch noetic-devel
fi

# Optional: rviz and its dependencies
if [ "${WITH_RVIZ}" = "1" ]; then
  cd $WS
  # python_qt_binding may already be cloned by WITH_RQT_BAG
  [ ! -d python_qt_binding ] && git clone https://github.com/ros-visualization/python_qt_binding --branch noetic-devel
  # resource_retriever/rosconsole_bridge/urdf may already be cloned by WITH_ROBOT_STATE_PUBLISHER
  [ ! -d resource_retriever ] && git clone https://github.com/ros/resource_retriever --branch noetic-devel
  [ ! -d rosconsole_bridge ] && git clone https://github.com/ros/rosconsole_bridge --branch noetic-devel
  [ ! -d urdf ] && git clone https://github.com/ros/urdf --branch noetic-devel
  git clone https://github.com/ros-visualization/interactive_markers --branch noetic-devel
  git clone https://github.com/ros-perception/laser_geometry --branch noetic-devel
  git clone https://github.com/ros/media_export --branch kinetic-devel
  git clone https://github.com/ros-planning/navigation_msgs --branch ros1
  git clone https://github.com/ros-visualization/view_controller_msgs --branch lunar-devel
  git clone https://github.com/ros-visualization/rviz --branch noetic-devel
fi
