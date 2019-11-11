#!/usr/bin/python

import requests
import json

result = requests.get('http://kube-prometheus:9090/api/v1/targets')
res_json = result.json()
target = res_json['data']['activeTargets']
for each in target:
    for key,val in each['labels'].items():
        if (str(key) == 'job' and str(val) == 'node-exporter'):
           node = each['discoveredLabels']
           data = {}
           data['name'] = str(node['__meta_kubernetes_pod_node_name'])
           data['ip'] = str(node['__meta_kubernetes_pod_host_ip'])
           data['state'] = str(each['health'])
           print(data)


