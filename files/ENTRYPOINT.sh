#!/usr/bin/env bash

sudo service openvswitch-switch start
sudo ovs-vsctl set-manager ptcp:6640

bash

sudo service openvswitch-switch stop
