#!/bin/sh

docker exec -it $(docker ps |grep mininet-docker | cut -f1 -d' ') /bin/bash
