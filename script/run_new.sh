#!/bin/bash

./para_config.sh
./install_tool.sh
./gen-ssl.sh
./etcd_env.sh
./etcd_service.sh
