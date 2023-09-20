kubectl apply -f .
kubectl exec -it nginx-pod -- bash
# log into the pod and find the test folder
ls
cd /test
echo "Hello World" > hello.txt 
cat hello.txt
# log into the worker node and remove the nginx container
sudo ctr --namespace k8s.io containers ls 
sudo ctr --namespace k8s.io tasks rm -f <container-id> 
sudo ctr --namespace k8s.io containers delete <container-id>  
# log into the master node again and see whether the hello.txt file still persists
kubectl exec -it nginx-pod -- bash
cd test/
ls
cat hello.txt