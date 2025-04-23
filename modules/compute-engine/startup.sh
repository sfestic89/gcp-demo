#!/bin/bash
apt-get update -y
apt-get install -y net-tools iputils-ping curl vim git

# Install kubectl
apt-get install -y apt-transport-https ca-certificates gnupg
curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] \
  https://apt.kubernetes.io/ kubernetes-xenial main" \
  > /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubectl
