FROM ubuntu:latest

RUN apt update
RUN apt install -y mininet iproute2 iputils-ping xterm wireshark
RUN apt install -y sudo vim tcpdump tmux
RUN apt install -y iputils-arping iputils-tracepath

RUN adduser --disabled-password --gecos '' mininet
RUN adduser mininet sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers 
RUN service openvswitch-switch start

USER mininet
WORKDIR /home/mininet

COPY --chown=mininet:mininet files/tmux.conf .tmux.conf
COPY --chown=mininet:mininet files/start-tmux.sh start-tmux.sh
RUN chmod +x ~/start-tmux.sh

RUN echo '#!/bin/bash' > ~/init.sh
RUN echo 'sudo service openvswitch-switch start > /dev/null 2>&1' >> ~/init.sh
RUN echo '~/start-tmux.sh' >> ~/init.sh
RUN chmod +x ~/init.sh

CMD ~/init.sh
