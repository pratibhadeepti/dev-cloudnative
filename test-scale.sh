#!/bin/bash

set -x

source inventory/env_bck.sh
time ansible-playbook -vvv -i kubespray/inventory/cnva/hosts.ini -s --private-key ssh/cnva-cluster1 autoscaling/autoscale.yml
