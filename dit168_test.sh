#!/bin/bash

# DIT168 car docker test script


echo "Starting Test setup...\n"
echo "Getting DIT168 test package...\n"
sudo mkdir DIT168-test
sudo cd DIT168-test
sudo wget http://www.cse.chalmers.se/~bergerc/DIT-168.zip
echo "Decompressing and moving into test package....\n"
sudo unzip DIT-168.zip


echo "Pulling latest docker  opendavinci-ubuntu-16.04....\n "
sudo docker pull seresearch/opendavinci-ubuntu-16.04-complete:latest

echo "Setting up test enviorment...\n"
sudo gnome-terminal --tab -e "sudo docker run -ti --rm --net=host -v $HOME/DIT-168:/opt/configuration -w /opt/configuration seresearch/opendavinci-ubuntu-16.04-complete:latest /opt/od4/bin/odsupercomponent --cid=111 --verbose=1"

sudo gnome-terminal --tab -e "docker run -ti --rm --net=host seresearch/opendavinci-ubuntu-16.04-complete:latest /opt/od4/bin/odsimvehicle --cid=111 --freq=10"

sudo gnome-terminal --tab -e "docker run -ti --rm --net=host -v $HOME/DIT-168:/opt/configuration -w /opt/configuration seresearch/opendavinci-ubuntu-16.04-complete:latest /opt/od4/bin/odsimirus --cid=111 --freq=10"

sudo xhost +

sudo gnome-terminal --tab -e "docker run -ti --rm --net=host --ipc=host -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME/DIT-168:/opt/configuration -w /opt/configuration seresearch/opendavinci-ubuntu-16.04-complete:latest /opt/od4/bin/odcockpit --cid=111"

sudo gnome-terminal --tab -e "docker run -ti --rm --net=host seresearch/opendavinci-ubuntu-16.04-complete:latest /opt/od4/bin/miniature/boxparker --cid=111 --freq=10"



#xhost +

#sudo gnome-terminal --tab -e "docker run -ti --rm --net=host --ipc=host -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME/DIT-168:/opt/configuration -w /opt/configuration seresearch/opendavinci-ubuntu-16.04-complete:latest /opt/od4/bin/odsimcamera --freq=10 --cid=111"

