# create a configmap named 'myconfig' with values mycolor=blue
kubectl create cm myconfig --from-literal=mycolor=blue
kubectl get cm
kubectl get cm myconfig -o yaml
# run the mypod.yaml file
kubectl apply -f mypod.yam
kubectl exec -it clarusweb-pod -- sh
echo $COLOR
# blue
# create a secret
echo -n "secret123" > password.txt
kubectl create secret generic mysecret --from-file=password=./password.txt
kubectl get secret
kubectl get secret mysecret -o yaml
kubectl apply -f mysecondpod.yaml