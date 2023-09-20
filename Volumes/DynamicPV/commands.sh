kubectl apply -f .
kubectl get pv,pvc
# you can check the PV under the folder whose path is "/opt/local-path-provisioner" in the worker node
# log into the worker node
cd /opt/local-path-provisioner/
cd pvc-f7ffae2b-cd30-4fd3-981a-8270e211ebec_default_sc-pv-claim/
echo "Dynamic PV is succesfully mounted" > index.html
# log in the master node
kubectl get po
kubectl exec -it clarus-pv-pod -- bash
cd /usr/share/nginx/html
ls
# see the index.html file is here
cat index.html
exit
# expose the pod as a new k8s service on the master node 
kubectl expose pod clarus-pv-pod --port=80 --type=NodePort
# find out which nodeport is assigned
kubectl get svc 
# (http://<public-workerNode-ip>:<node-port>)