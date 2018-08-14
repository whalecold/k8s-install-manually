#!/bin/bash

config_file=etcds.conf
declare -A map=()
#eval $(awk -F " " 'BEGIN{}{etcd_map[$1] = $2;}END{for (key in etcd_map){ print map[key]=etcd_map[key]};}' ${config_file})
eval $(awk -F " " 'BEGIN{}{etcd_map[$1] = $2;}END{for (key in etcd_map){ print "map["key"]="etcd_map[key]}}' ${config_file})

#echo ${!map[@]} key
#echo ${map[@]} value

node_ip=""
envStr="ETCD_ENDPOINTS=\""
nodes="export ETCD_NODES="
nodes_ips="export NODES_IPS=\""
for key in ${!map[@]}
do
    #echo key : $key " "${map[$key]}
    envStr=${envStr}"https://${map[$key]}:2379,"
    nodes=${nodes}${key}"=https://"${map[$key]}":2380,"
    nodes_ips=${nodes_ips}${map[$key]}" "
    if [ "$1" == "$key" ];then
	node_ip=${map[$key]}
    fi
done

if [ "$node_ip" == "" ];then
    echo etcd_name $1 not in config : $config_file
    exit 1
fi

envStr=${envStr%,}\"
/usr/bin/sed -i "s#^.*ETCD_ENDPOINTS.*\$#${envStr}#g" env.sh

nodes=${nodes%,}
/usr/bin/sed -i "s#^.*ETCD_NODES.*\$#${nodes}#g" etcd_env.sh

node_name="export NODE_NAME="$1
node_ips="export NODE_IP="$node_ip
nodes_ips=$nodes_ips"\""
/usr/bin/sed -i "s#^.*NODE_NAME.*\$#${node_name}#g" etcd_env.sh
/usr/bin/sed -i "s#^.*NODE_IP.*\$#${node_ips}#g" etcd_env.sh
/usr/bin/sed -i "s#^.*NODES_IPS.*\$#${nodes_ips}#g" etcd_env.sh

