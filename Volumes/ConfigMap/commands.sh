echo "greeting: Hei" > config
kubectl create configmap demo-config --from-file=./config
kubectl apply -f configmap_pod.yaml
kubectl get po,svc -o wide
kubectl cluster-info
curl <worker-ip>:<port>
# Hei, Clarusway!