#!/usr/bin/env bash

# OpenStack
export OS_PROJECT_DOMAIN_ID=88f33626ca6a4d8da30f3765582be31b
export OS_USER_DOMAIN_ID=88f33626ca6a4d8da30f3765582be31b
export OS_PROJECT_NAME=eu-de_morpheus_kubernetes
export OS_USERNAME='morpheus-connector'
export OS_AUTH_URL=https://iam.eu-de.otc.t-systems.com/v3
export OS_IDENTITY_API_VERSION=3
export OS_IMAGE_API_VERSION=2
export OS_REGION_NAME=eu-de
export OS_AZ=eu-de-02
export OS_PROJECT_ID=062d196f1553456485c8cb145af6f40e
export OS_IMAGE_ID="d9990a45-67fa-4d15-8739-ecdc71058e1e"
export OS_NETWORK_ID="79604d4b-0462-4093-b1be-8b58522d37b5"
export ADMIN_KEY_NAME="Admin-cluster1"
export CUST_KEY_NAME="Customer-cluster"
export SUBNET_ID="39dc740a-2925-46a0-a757-363ff3e1e82a"
export FLOATING_NETWORK_ID="0a2228f2-7f8a-45f1-8e09-9039e1d09975"
export NEXUS_PORT=8081
export PROMETHEUS_PORT=32000
export GRAFANA_PORT=32100
export OS_STORAGECLASS=SSD

#configure admin cluster
export ADMIN_INSTANCE_VALUE=3
export ADMIN_INSTANCE_SUFFIX="admin"
export VOLUME_SIZE_ADMIN=50
export OS_FLAVOR_NAME_ADMIN="s2.xlarge.2"

#configure customer cluster
export SUB_INSTANCE_VALUE=2
export NUM_SUB_MASTER=1
export NUM_SUB_WORKER=1
export OS_FLAVOR_NAME_CUST_MASTER="s2.large.2"
export OS_FLAVOR_NAME_CUST_WORKER="s2.2xlarge.2"
export SUB_INSTANCE_SUFFIX="cloud"
export VOLUME_SIZE_CUST_MASTER=50
export VOLUME_SIZE_CUST_WORKER=50

#echo "Please enter your OpenStack Password: "
#read -sr OS_PASSWORD_INPUT
export OS_PASSWORD=Ibonapoba986

# Kubernetes
export K8S_CLUSTER_NAME="cloudibility"
