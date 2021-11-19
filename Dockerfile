FROM ubuntu:18.04

RUN echo "wireshark-common wireshark-common/install-setuid boolean true" | debconf-set-selections

RUN DEBIAN_FRONTEND=noninteractive \
    apt update && apt install -y \
    docker.io \
    gcc \
    git \
    iproute2 \
    iputils-arping \
    iputils-ping \
    iputils-tracepath \
    make \
    mininet \
    net-tools \
    openvswitch-testcontroller \
    python-docker \
    sudo \
    tcpdump \
    tmux \
    traceroute \
    vim \
    vlan \
    wireshark \
    xterm \
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

# Install Mininet branch w/ DockerHost support
RUN git clone https://github.com/peddamat/mininet.git

WORKDIR /home/mininet/mininet
RUN git checkout dev-dockerhost
RUN make mnexec
RUN sudo make install-mnexec

WORKDIR /home/mininet
RUN echo 'alias python=python2' >> ~/.bashrc
RUN echo "export PYTHONPATH=$HOME/mininet" >> ~/.bashrc
RUN echo "alias run='sudo PYTHONPATH=$HOME/mininet python'" >> ~/.bashrc
RUN echo "alias rund='sudo PYTHONPATH=$HOME/mininet python -m pdb'" >> ~/.bashrc

EXPOSE 6633 6653 6640

ENTRYPOINT ["/home/mininet/ENTRYPOINT.sh"]
