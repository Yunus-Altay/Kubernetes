# Try to connect the pods for testin
kubectl get pod,svc -A -o wide
kubectl -n clarusshop-ns exec -it <clarusshop-podName> -- sh
curl <ip of clarusdb pod>
curl clarusdb-svc.clarusdb-ns
exit
kubectl -n nginx-ns exec -it <nginx-podName> -- bash
curl <ip of clarusdb pod>
curl clarusdb-svc.clarusdb-ns
exit
# As we saw, we could connect to clarusdb pod from anywhere
---
# network-policy-1
kubectl get ns --show-labels
# Show the labels of all namespaces
kubectl get pod,svc -A -o wide
kubectl -n clarusshop-ns exec -it clarusshop-deployment-6876dc9874-6gcxr -- sh
curl <ip of clarusdb pod>
curl clarusdb-svc.clarusdb-ns
exit
kubectl -n nginx-ns exec -it nginx-deployment-ff6774dc6-z2czn -- bash
curl <ip of clarusdb pod>
curl clarusdb-svc.clarusdb-ns
exit
# This time we could connect to clarusdb pod from clarusshop pod, but not connected from nginx pod
# The ingress rule of the NetworkPolicy allows connection to the pods with the label 'db: clarusdb' in namespaces with the label'clarusdb-ns' from;
## only pods in namespaces with the label 'kubernetes.io/metadata.name: clarusshop-ns'
---
# network-policy-2
# The ingress rule of the NetworkPolicy allows connection to the pods with the label 'db: clarusdb' in namespaces'clarusdb-ns' from;
## any pod in the "clarusdb-ns" namespace with the label "role=frontend"
## any pod in a namespace with the label "kubernetes.io/metadata.name: clarusshop-ns"
##IP addresses in the ranges 172.16.0.0–172.16.0.255 and 172.16.2.0–172.16.255.255 (ie, all of 172.16.0.0/16 except 172.16.180.0/24)
---
# network-policy-3
# This NetworkPolicy is slightly different than the others
# The rule allows connection to the pods with the label 'db: clarusdb' in 'clarusdb-ns' namespace from;
## only pods with the label 'role: frontend' in namespaces with the label'kubernetes.io/metadata.name: clarusshop-ns'
