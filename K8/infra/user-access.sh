#!/usr/bin/bash

# Script to create kubeconfig file for the user specified

usernamespace=$1
usersa=$2

if [[ $# < 2 ]]; then
   echo 'Arguments mising!!! Provide namespace and username'
   exit 1
else
   echo 'Success'
fi

# Check if namespace exists

x=`kubectl get namespaces | awk '{ if (NR!=1) { print $1 } }'`
flag=0
for i in $x
do
   if [[ $i == $1 ]]; then
      flag=1
      break
   fi
done
if [[ $flag -eq 0 ]]; then
   echo "Namespace doesn't exist \n create a namespace using the following command: \n kubectl create namespace <name>"
fi

# Check if useraccount exists
y=`kubectl get sa | awk '{ if (NR!=1) { print $1 } }'`
count=0
for j in $y
do
   if [[ $j == $2 ]]; then
      count=1
      break
   fi
done
if [[ $count -eq 0 ]]; then
   echo "Username doesn't exist \n create a user account using the following command: \n kubectl create sa <name>"
fi

secret=$(kubectl get sa $2 -n $1 -o json | jq -r .secrets[].name)      
kubectl get -n $1 secret $secret -o json | jq -r '.data["ca.crt"]' | base64 -d > $2-ca.crt
user_token=$(kubectl get -n $1 secret $secret -o json | jq -r '.data["token"]' | base64 -d)
myip=`hostname -i`
export endpoint="https://$myip:6443"
kubectl config set-cluster cluster-$1   --embed-certs=true   --server=$endpoint --certificate-authority=$2-ca.crt
kubectl config set-credentials $2 --token=$user_token
kubectl config set-context $2 --cluster=cluster-$1 --user=$2 --namespace=$1
kubectl config use-context $2

