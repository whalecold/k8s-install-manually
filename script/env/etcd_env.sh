#!/bin/bash

export NODE_NAME=etcd03
export NODE_IP=45.76.181.139
export NODES_IPS="47.88.53.93 45.76.181.139 202.182.121.61 "
# etcd 集群间通信的IP和端口
export ETCD_NODES=etcd02=https://47.88.53.93:2380,etcd03=https://45.76.181.139:2380,etcd01=https://202.182.121.61:2380
# 导入用到的其它全局变量：ETCD_ENDPOINTS、FLANNEL_ETCD_PREFIX、CLUSTER_CIDR
source ./env/env.sh

