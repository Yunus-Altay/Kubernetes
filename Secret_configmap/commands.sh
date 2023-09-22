##### mypod.yaml #####
# create a configmap named 'myconfig' with values mycolor=blue
kubectl create cm myconfig --from-literal=mycolor=blue
kubectl get cm
kubectl get cm myconfig -o yaml
# run the mypod.yaml file
kubectl apply -f mypod.yam
kubectl exec -it clarusweb-pod -- sh
echo $COLOR
# blue

##### mysecondpod.yaml #####
# create a secret
echo -n "secret123" > password.txt
kubectl create secret generic mysecret --from-file=password=./password.txt
kubectl get secret
kubectl get secret mysecret -o yaml
kubectl apply -f mysecondpod.yaml

##### mythirdpod.yaml #####
# Encode the secrets using base64 
echo -n 'admin' | base64
# YWRtaW4=
echo -n '1f2d1e2e67df' | base64
# MWYyZDFlMmU2N2Rm
kubectl apply -f mythirdpod.yaml

##### mydeployment.yaml #####
# use configmaps as files from a pod
kubectl create cm myconfig --from-literal=game=DOTA --from-literal=type=MOBA --from-literal=company=steam --from-literal=platform=steam
kubectl get cm
kubectl get cm myconfig -o yaml
kubectl apply -f mydeployment.yaml
kubectl exec -it <pod-name> --sh
cd /usr/share/nginx/html
ls