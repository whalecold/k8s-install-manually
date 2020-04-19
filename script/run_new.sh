#!/bin/bash

./para_config.sh $1

#./install_tool.sh
export PATH=/usr/k8s/bin:$PATH
source ./env/etcd_env.sh
./gen-ssl.sh
./gen_etcd.sh
./etcd_service.sh
