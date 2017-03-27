## Deployment

### Minikube

```
$ minikube start
```

#### Deploy PostgreSQL

```
$ kubectl create -f postgres.yaml
```

Verify that the service and pods are created

```
$ kubectl get services -w
```

##### Connect to PostgreSQL from host

```
# Get the minikube VM IP address
$ minikube ip

# Get the PostgreSQL minikube node port
$ kubectl get service postgres -o 'jsonpath={.spec.ports[0].nodePort}'

# Connect to PostgreSQL
$ psql -h $(minikube ip) -p $(kubectl get service postgres -o 'jsonpath={.spec.ports[0].nodePort}') -U postgres
```

##### Connect to PostgreSQL from a new pod

```
$ kubectl run -i -t --rm psql --image=postgres --restart=Never --command -- psql -h postgres -U postgres
```

#### Deploy Tweeter front-end

```
$ kubectl create -f frontend.yaml
```

Wait for the pods to be `Running`

```
$ kubectl get pods -w
```

Take note of a pod id (we'll denote by `$POD_ID`)

Execute Rails migrations

```
$ kubectl exec $POD_ID -- rake db:create
$ kubectl exec $POD_ID -- rake db:migrate
```

##### Connect to the Tweeter front end

```
$ kubectl get services
```

Take note of the `tweeter-frontend` port, then visit `$(minikube ip)`:port.
