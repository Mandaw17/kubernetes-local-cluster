#!/bin/bash
set -eux

# Only init if not already initialized
if [ ! -f /etc/kubernetes/admin.conf ]; then
  kubeadm init \
    --apiserver-advertise-address=192.168.56.10 \
    --pod-network-cidr=192.168.0.0/16 \
    | tee /home/vagrant/kubeinit.log
fi

# Configure kubectl for vagrant user
mkdir -p /home/vagrant/.kube
cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown vagrant:vagrant /home/vagrant/.kube/config
