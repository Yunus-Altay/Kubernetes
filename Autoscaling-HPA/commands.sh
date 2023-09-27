kubectl apply -f php-apache.yaml
kubectl apply -f web.yaml
kubectl get po,svc
# curl <public-worker node-ip>:<node-port>
# kubectl autoscale deployment php-apache --cpu-percent=50 --min=2 --max=10 
# kubectl autoscale deployment web-deployment --cpu-percent=50 --min=3 --max=5 
kubectl apply -f hpa-php-apache.yaml
kubectl apply -f hpa-web.yaml
kubectl get hpa
kubectl get po # see, new pods are being created
# split the terminal and monitor the resources
watch -n3 kubectl get service,hpa,pod -o wide
# HPA line under TARGETS shows <unknown>/50%. The unknown means the HPA can't idendify the current use of CPU
# metrics can't be calculated
# metrics server has to be uploaded to the cluster
kubectl delete -n kube-system deployments.apps metrics-server
wget https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.6.3/components.yaml
# select the deployment part in the file and add the below line to containers.args field under the deployment object
# - --kubelet-insecure-tls
# since we have no certificate we will bypass the certification request, that's why we added the line above in the file
kubectl apply -f components.yaml
kubectl top pods
kubectl top nodes
kubectl get hpa # see, new values can be seen
# let us increase the load on the pods
kubectl run -it --rm load-generator --image=busybox /bin/sh 
while true; do wget -q -O- http://<puplic ip>:<port number of php-apache-service>; done
# open another terminal
kubectl run -it --rm load-generator_2 --image=busybox /bin/sh 
while true; do wget -q -O- http://<puplic ip>:<port number of php-apache-service>; done
# watch how the HPA reacts on the splitted terminal