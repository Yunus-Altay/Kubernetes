############ Determine which version to upgrade to ############
# Find the latest 1.28.x-* version in the list.
# It should look like 1.28.x-*, where x is the latest patch.
apt update
apt-cache madison kubeadm

############ Upgrading control plane node ############
# check the kubeadm version before updating it
kubeadm version
# replace x in 1.28.x-* with the latest patch version
apt-mark unhold kubeadm && \
apt-get update && apt-get install -y kubeadm='1.28.x-*' && \
apt-mark hold kubeadm
# verify that the download works and has the expected version
kubeadm version
# verify the upgrade plan
kubeadm upgrade plan
# replace x with the patch version you picked for this upgrade
sudo kubeadm upgrade apply v1.28.x
# SUCCESS! Your cluster was upgraded to "v1.28.x". Enjoy!
# Now that your control plane is upgraded, please proceed with upgrading your kubelets if you haven't already done so.
# for the other control plane nodes;
sudo kubeadm upgrade node # instead of 'sudo kubeadm upgrade apply'

############ Upgrade kubelet and kubectl of master node ############
# We are about to upgrade the kubelet and kubectl on the master node
# cordon the master node so that if there is a pod/s on it, they will be evicted and redeployed on another node
# replace <master-node-to-drain> with the name of your master node you are draining
kubectl drain <master-node-to-drain> --ignore-daemonsets
# upgrade the kubelet and kubectl
# replace x in 1.28.x-* with the latest patch version
apt-mark unhold kubelet kubectl && \
apt-get update && apt-get install -y kubelet='1.28.x-*' kubectl='1.28.x-*' && \
apt-mark hold kubelet kubectl
# restart the kubelet
sudo systemctl daemon-reload
sudo systemctl restart kubelet
# replace <master-node-to-uncordon> with the name of your master node
kubectl uncordon <master-node-to-uncordon>
# verify the status of the cluster
kubectl get nodes # see the version of the master node upgraded

############ Upgrade kubelet and kubectl of worker node ############
# We are about to upgrade the kubelet and kubectl on the worker node
# untaint the master node if there is a single worker node and the master node is tainted
# cordon the worker node whose components are about to be upgraded so that the pods can be redeployed on another node
# replace <worker-node-to-drain> with the name of your worker node you are draining
kubectl drain <worker-node-to-drain> --ignore-daemonsets
# upgrade the kubelet and kubectl
# replace x in 1.28.x-* with the latest patch version
apt-mark unhold kubelet kubectl && \
apt-get update && apt-get install -y kubelet='1.28.x-*' kubectl='1.28.x-*' && \
apt-mark hold kubelet kubectl
# restart the kubelet
sudo systemctl daemon-reload
sudo systemctl restart kubelet
# replace <worker-node-to-uncordon> with the name of your worker node
kubectl uncordon <worker-node-to-uncordon>
# verify the status of the cluster
kubectl get nodes # see the version of the worker node upgraded