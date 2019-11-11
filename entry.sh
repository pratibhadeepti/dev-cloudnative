#!/bin/bash

source $1
mkdir -p build_logs/${K8S_CLUSTER_NAME}
ansible-playbook -vvv site.yml --extra-vars cluster_type=Sub > build_logs/${K8S_CLUSTER_NAME}/${K8S_CLUSTER_NAME}.log
exec "$@"
