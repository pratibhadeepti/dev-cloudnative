#!/bin/bash

./node_state.py > data/state.txt

source ${INI}

if [ ${TYPE} == "Admin" ]; then
   x=${ADMIN_INSTANCE_SUFFIX}
elif [ ${TYPE} == "Sub" ]; then
   x=${SUB_INSTANCE_SUFFIX}
fi

if [ ${TYPE} == "Admin" ]; then
   y=${ADMIN_KEY_NAME}
elif [ ${TYPE} == "Sub" ]; then
   y=${CUST_KEY_NAME}
fi

ansible-playbook -vvv -i kubespray/inventory/${K8S_CLUSTER_NAME}/${x}_hosts.ini -u ${USER} -s --private-key ssh/${y} scale.yml --extra-vars ktype=${TYPE}
