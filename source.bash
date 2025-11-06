# setup this file:
# Eg1:
# echo 'source $HOME/ros_from_src/source.bash' >> ~/.bashrc  #CHANGE to path on your system
# Eg2:
# echo 'source $HOME/starship/ros_from_src/source.bash' >> ~/.bash_aliases  #CHANGE to path on your system
export ROS_BUILD_DIR=$(dirname ${BASH_SOURCE[0]})/build
export CMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH:$ROS_BUILD_DIR/ros/lib/cache
export PATH=$ROS_BUILD_DIR/ros/local/bin:$PATH
export PYTHONPATH=$PYTHONPATH:$ROS_BUILD_DIR/ros/local/lib/python3.12/dist-packages/
