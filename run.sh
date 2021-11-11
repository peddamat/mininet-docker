#!/bin/sh

docker run -it --privileged --env DISPLAY=$(hostname):0.0 mininet-docker:latest 
