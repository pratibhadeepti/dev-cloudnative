#!/usr/bin/env bash

# OpenStack
export OS_AUTH_URL=https://api.cbk.cloud.syseleven.net:5000/v3
export OS_IDENTITY_API_VERSION=3
export OS_PROJECT_ID=4258d090855541aeb85e3e7af21764b2
export OS_USER_DOMAIN_NAME="Default"
export OS_TENANT_ID=$OS_PROJECT_ID
unset OS_TENANT_NAME
export OS_INTERFACE=public
export OS_ENDPOINT_TYPE=public
export OS_USERNAME="cloudibility-report-test@cloudibility.io"
export OS_REGION_NAME="cbk"
export OS_IMAGE_ID="40a82fa2-3c28-49f9-ae9a-fa8e14be9709"
export OS_FLAVOR_NAME_MASTER="m1.small"
export OS_FLAVOR_NAME_WORKER="m1.small"
export OS_NETWORK_ID="ad939364-e95a-4466-9e61-43f998e38a9f"
export OS_KEYPAIR_NAME="ansible-cnvatest"
if [ -z "$OS_REGION_NAME" ]; then unset OS_REGION_NAME; fi
echo "Please enter your OpenStack Password: "
read -sr OS_PASSWORD_INPUT
export OS_PASSWORD=$OS_PASSWORD_INPUT
export OS_DEFAULT_STORAGECLASS="quobyte"
export OS_DEFAULT_AZ="nova"

# Kubernetes
export K8S_CLUSTER_NAME="cnva-test"
