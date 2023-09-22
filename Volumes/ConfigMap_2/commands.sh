kubectl apply -f .
kubectl get cm
kubectl get cm nginx-config -o yaml
kubectl get deploy
kubectl get po
kubectl exec it <pod-name> -- sh
cd /usr/share/nginx/html/
ls
cat index.html # see, the volume of config type mounted and the config file is here
exit
kubectl get svc
curl < worker-ip >:30002