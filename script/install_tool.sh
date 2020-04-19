#!/bin/bash

echo "202.182.121.61 k8s-api.virtual.local k8s-api" >> /etc/hosts
mkdir -p /usr/k8s/bin
cp ./env/env.sh /usr/k8s/bin

#install cfssl
wget https://pkg.cfssl.org/R1.2/cfssl_linux-amd64
chmod +x cfssl_linux-amd64
mv cfssl_linux-amd64 /usr/k8s/bin/cfssl

wget https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64
chmod +x cfssljson_linux-amd64
sudo mv cfssljson_linux-amd64 /usr/k8s/bin/cfssljson

wget https://pkg.cfssl.org/R1.2/cfssl-certinfo_linux-amd64
chmod +x cfssl-certinfo_linux-amd64
sudo mv cfssl-certinfo_linux-amd64 /usr/k8s/bin/cfssl-certinfo

export PATH=/usr/k8s/bin:$PATH
echo "export PATH=/usr/k8s/bin:$PATH" >> /etc/rc.local
echo "export PATH=/usr/k8s/bin:$PATH" >> ~/.bashrc


wget https://github.com/coreos/etcd/releases/download/v3.3.9/etcd-v3.3.9-linux-amd64.tar.gz
tar -xvf etcd-v3.3.9-linux-amd64.tar.gz
mv etcd-v3.3.9-linux-amd64/etcd* /usr/k8s/bin/
rm -rf etcd-v3.3.9-linux-amd64*
