# log into the worker node and create a folder
mkdir pv-data && cd pv-data
echo "Welcome to my k8s persistent volume page" > index.html
pwd # note the path under which the folder exists
# log into the master node
kubectl apply -f .
kubectl get pod clarus-pod
kubectl exec -it clarus-pod -- /bin/bash
# run the following command inside the pod
curl http://localhost/
# log into the worker node and change the index.html
cd pv-data
echo "Kubernetes Rocks!!!!" > index.html
# log into the master node and check the pod again
kubectl exec -it clarus-pod -- /bin/bash
curl http://localhost/
# expose the pod as a new k8s service on the master node
kubectl expose pod clarus-pod --port=80 --type=NodePort
kubectl get svc
# check the browser
# (http://<public-workerNode-ip>:<node-port>)