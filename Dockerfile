FROM ubuntu:latest

RUN apt update
RUN apt install -y mininet openvswitch-testcontroller iproute2 iputils-ping xterm wireshark
RUN apt install -y sudo vim git tmux
RUN apt install -y tcpdump iputils-arping iputils-tracepath
RUN apt install -y git

RUN adduser --disabled-password --gecos '' mininet
RUN adduser mininet sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers 
RUN service openvswitch-switch start

USER mininet
WORKDIR /home/mininet

COPY --chown=mininet:mininet files/init.sh init.sh
RUN chmod +x ~/init.sh

COPY --chown=mininet:mininet files/tmux.conf .tmux.conf
COPY --chown=mininet:mininet files/start-tmux.sh start-tmux.sh
RUN chmod +x ~/start-tmux.sh

CMD ~/init.sh
