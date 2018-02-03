kube-lego Setup
===

##### Create `kube-lego` namespace

```bash
kubectl create namespace kube-lego
```

##### Deploy `kube-lego`

```bash
helm install --namespace kube-lego --name kube-lego -f kube-lego-values.yaml stable/kube-lego
```
