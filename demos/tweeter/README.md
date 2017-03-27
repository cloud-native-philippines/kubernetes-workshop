## Deployment

### Minikube

```
$ minikube start
```

##### Create PostgreSQL database

```
$ kubectl create -f postgres.yaml
```

Verify that the service and pods are created

```
$ kubectl get services -w
```

##### Connect to PostgreSQL

```
# Get the minikube VM IP address
$ minikube ip

# Get the PostgreSQL minikube node port
$ kubectl get service postgres -o 'jsonpath={.spec.ports[0].nodePort}'

# Connect to PostgreSQL
$ psql -h $(minikube ip) -p $(kubectl get service postgres -o 'jsonpath={.spec.ports[0].nodePort}') -U postgres
```
