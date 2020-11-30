#!/bin/bash

sudo apt update && sudo apt install curl gnupg2 lsb-release
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'
sudo apt update && apt upgrade -y
sudo apt install ros-foxy-ros-base
echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc
sudo apt install -y python3-pip
pip3 install -U argcomplete

sudo apt-get install python3-pip
sudo apt-get install i2c-tools

sudo mv 99-com.rules /lib/udev/rules.d/

sudo groupadd i2c
sudo groupadd spi
sudo groupadd gpio

sudo adduser ubuntu gpio
sudo adduser ubuntu spi
sudo adduser ubuntu i2c

sudo apt-get install -y lua5.1 alsa-utils
wget https://archive.raspberrypi.org/debian/pool/main/r/raspi-config/raspi-config_20201108_all.deb
sudo dpkg -i raspi-config_20201108_all.deb