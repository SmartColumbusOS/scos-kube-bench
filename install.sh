#!/bin/sh

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

wget http://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz -O /tmp/helm.tar.gz
tar xzf /tmp/helm.tar.gz -C /tmp --strip-components=1
chmod +x /tmp/helm
sudo mv /tmp/helm /usr/local/bin/helm