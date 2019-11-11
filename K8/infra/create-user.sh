#!/bin/bash
set -x
#Script to create a non-admin user in a specified cluster with specified roles

clustername=$1

username=$2

resources=$3

permissions=$4

if [[ $# < 4 ]]; then
   echo 'Arguments mising!!! Provide namespace, username, rsources and permissions for the user'
   exit 1
else
   echo 'Success'
fi

kubectl create sa $2 -n $1

kubectl create role $2-role --verb=$4 --resource=$3 -n $1

kubectl create rolebinding $2-rolebind --role=$2-role --serviceaccount=$1:$2

bash user-access.sh $1 $2
