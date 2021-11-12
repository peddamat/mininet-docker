FROM ubuntu:18.04

RUN apt update
RUN apt install -y mininet openvswitch-testcontroller net-tools iproute2 iputils-ping xterm wireshark
#RUN apt install -y mininet iproute2 iputils-ping xterm wireshark
RUN apt install -y sudo vim git tmux
RUN apt install -y tcpdump iputils-arping iputils-tracepath
RUN apt install -y git

RUN adduser --disabled-password --gecos '' mininet
RUN adduser mininet sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers 
#RUN service openvswitch-switch start

USER mininet
WORKDIR /home/mininet

RUN ln -s /usr/lib/python2.7/dist-packages/mininet/examples/ ./mininet-examples

COPY --chown=mininet:mininet files/ENTRYPOINT.sh ENTRYPOINT.sh
RUN chmod +x ~/ENTRYPOINT.sh

COPY --chown=mininet:mininet files/tmux.conf .tmux.conf
COPY --chown=mininet:mininet files/start-tmux.sh start-tmux.sh
RUN chmod +x ~/start-tmux.sh

RUN echo 'alias python=python2' >> ~/.bashrc

EXPOSE 6633 6653 6640

#CMD ~/init.sh
ENTRYPOINT ["/home/mininet/ENTRYPOINT.sh"]
