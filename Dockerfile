FROM ubuntu:18.04

RUN echo "wireshark-common wireshark-common/install-setuid boolean true" | debconf-set-selections

RUN DEBIAN_FRONTEND=noninteractive \
    apt update && apt install -y \
    mininet \
    openvswitch-testcontroller \
    net-tools \
    iproute2 \
    iputils-ping \
    vlan \
    xterm \
    wireshark \
    tcpdump \
    iputils-arping \
    iputils-tracepath \
    sudo \
    vim \
    git \
    tmux \
    && rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos '' mininet
RUN adduser mininet sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers 

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

ENTRYPOINT ["/home/mininet/ENTRYPOINT.sh"]
