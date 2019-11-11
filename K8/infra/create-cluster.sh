#!/bin/bash
set -x
#Script to create a cluster namespace and admin user with limited permissions

clustername=$1

username=$1-admin

if [[ $# < 1 ]]; then
   echo 'Arguments mising!!! Provide namespace name'
   exit 1
else
   echo 'Success'
fi

cat >> $username-role.yaml << EOF
---
apiVersion: v1
kind: Namespace
metadata:
  name: $1

---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: $username
  namespace: $1

---
kind: Role
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: $username-full-access-$1
  namespace: $1
rules:
- apiGroups: ["*", "extensions", "apps"]
  resources: ["*"]
  verbs: ["*"]
- apiGroups: ["batch"]
  resources:
  - jobs
  - cronjobs
  verbs: ["*"]
---
kind: Role
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: $username-default-role
  namespace: default
rules:
- apiGroups: ["*"]
  resources: ["pods", "pods/attach", "pods/exec", "pods/portforward", "pods/proxy", "configmaps", "endpoints", "persistentvolumeclaims", "replicationcontrollers", "replicationcontrollers/scale", "secrets", "serviceaccounts", "services", "services/proxy", "daemonsets", "deployments", "deployments/rollback", "deployments/scale", "replicasets", "replicasets/scale", "statefulsets", "statefulsets/scale", "horizontalpodautoscalers", "jobs", "cronjobs"]
  verbs: ["*"]

---
kind: ClusterRole
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: $username-clusterrole
rules:
- apiGroups: [""]
  resources: ["namespaces"]
  verbs: ["get", "list", "create", "watch"]

---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: $username-rolebind-$1
  namespace: $1
subjects:
- kind: ServiceAccount
  name: $username
  namespace: $1
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: $username-full-access-$1

---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: $username-rolebind-default
  namespace: default
subjects:
- kind: ServiceAccount
  name: $username
  namespace: $1
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: $username-default-role

---
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: $username-clusterrolebind
subjects:
- kind: ServiceAccount
  name: $username
  namespace: $1
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: $username-clusterrole

EOF

kubectl create -f $username-role.yaml

bash user-access.sh $1 $username

