kubectl apply -f web-flask.yaml
kubectl get po -o wide
kubectl exec -it forcurl -- sh
# ping 10.244.1.3
kubectl scale deploy web-flask-deploy --replicas=0
kubectl get pods -o wide
kubectl scale deploy web-flask-deploy --replicas=3
kubectl get pods -o wide
# IP addresses have changed
kubectl appy -f myservice.yaml
kubectl get svc -o wide
kubectl describe svc web-flask-svc
# ping again inside the container
curl <IP of service web-flask-svc>:3000
curl web-flask-svc:3000
# http://<public-node-ip>:<node-port>
# http://<public-node-ip>:30036
# services within the same namespace find other Services just by their name
# services in different namespaces have to express their respective namespaces as well
# make a change in the yaml files and change the namespaces of the deployment and the service
kubectl exec -it forcurl -- sh
curl web-flask-svc.demo:3000
curl web-flask-svc.demo.svc.cluster.local:3000