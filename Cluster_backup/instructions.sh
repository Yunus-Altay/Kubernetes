kubectl get all --all-namespaces -o yaml > all-deploy-services.yaml # Save all the resource configs to have a back-up of the cluster
# This is the short way and there is another way

# take a snapshot of ETCD
# check etcdctl version. If needed, set the variable to its new value
etcdctl version
export ETCDCTL_API=3

# view the manifest file to gather the related info to take a snapshot
vim /etc/kubernetes/manifests/etcd.yaml

# take a snapshot
etcdctl snapshot save snapshot.db \
--endpoints=127.0.0.1:2379 \
--cacert=/etc/kubernetes/pki/etcd/ca.crt \
--cert=/etc/kubernetes/pki/etcd/server.crt \
--key=/etc/kubernetes/pki/etcd/server.key

# view the snapshot
etcdctl snapshot status snapshot.db

# restore ETCD from the snapshot
etcdctl snapshot restore --data-dir /var/lib/etcd-from-backup snapshot.db

# update the etcd folder path in the manifest file (.volumes.hostPath.path ==> /var/lib/etcd) to its new value (/var/lib/etcd-from-backup snapshot.db)
vim /etc/kubernetes/manifests/etcd.yaml

# It may take a several minutes before the ETCD comes online again
kubectl get po -n kube-system