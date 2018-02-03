Minikube + Rook
===

```
minikube start && minikube ssh
```

```
cd /bin
sudo curl -O https://raw.githubusercontent.com/ceph/ceph-docker/master/examples/kubernetes-coreos/rbd
sudo chmod +x /bin/rbd
rbd
```

```
cd /Users/aisrael/workspaces/amihan/kubernetes-workshop/rook/demo/kubernetes
kubectl create -f rook-operator.yaml
kubectl get pod -w | grep rook-operator

kubectl create -f rook-cluster.yaml
kubectl -n rook get pod -w

export MONS=$(kubectl -n rook get pod mon0 mon1 mon2 -o json|jq ".items[].status.podIP"|tr -d "\""|sed -e 's/$/:6790/'|paste -s -d, -)
sed 's#INSERT_HERE#'$MONS'#' rook-storageclass.yaml | kubectl create -f -
kubectl create -f mysql.yaml
```