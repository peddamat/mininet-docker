#!/bin/sh

docker run -it \
    --rm \
    --privileged \
    --pid=host \
    --env DISPLAY=$(hostname):0.0 \
    -v $(pwd)/scripts:/home/mininet/scripts \
    -v /Users/me/learning/mininet/mininet:/home/mininet/mininet \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --name mininet-docker \
    mininet-docker:latest

