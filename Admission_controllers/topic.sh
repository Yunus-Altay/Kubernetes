# Admission controller is a piece of code (plugin) that makes it possible to govern a cluster's configuration changes and deployments in k8s
# To see which admission plugins are enabled
sudo snap install kube-apiserver
kube-apiserver -h | grep enable-admission-plugins

# The admission controller 'NamespaceAutoProvision' lets you create a resource in a namespace that does not exists
# Normally if a namespace in which a resource defined does not exists, the source would not be created.
# In this case, this admission controller is useful in deployments that do not want to restrict the creation of a namespace before its usage

kubectl run nginx-pod --image nginx -n clarus
# Error from server (NotFound): namespaces "clarus" not found

# Enable the admission controller
sudo vi /etc/kubernetes/manifests/kube-apiserver.yaml
# Modify the '- --enable-admission-plugins=NodeRestriction' and make an addition
# "- --enable-admission-plugins=NodeRestriction,NamespaceAutoProvision"

kubectl get ns
kubectl run nginx-pod --image nginx -n clarus
# Pod is running in the 'clarus' namespace without having created the namespace beforehand

# You may turn off an admission controller
# ServiceAccount is a default admission controller which assigns a 'default' service account to a pod automatically

# Let's disable it
sudo vi /etc/kubernetes/manifests/kube-apiserver.yaml
# Add the line in the file to disable the admission controller
# "- --disable-admission-plugins=ServiceAccount"

kubectl run apache-pod --image=httpd
kubectl get pod apache-pod -o yaml | grep -i serviceaccount
# No output