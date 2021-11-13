#!/bin/sh

docker run -it --privileged --env DISPLAY=$(hostname):0.0 -v $(PWD)/scripts:/home/mininet/scripts mininet-docker:latest 
