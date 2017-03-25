Kubernetes Workshop
====

## Google Cloud Platform

#### GCP SDK installation

##### OS X + Homebrew users

```
brew cask install google-cloud-sdk
```

##### Other platforms

Alternatively, follow instructions at:

[https://cloud.google.com/sdk/downloads](https://cloud.google.com/sdk/downloads)


#### GCP Configuration

```
gcloud auth login
```

Will open a browser window.

Set `gcloud` project

```
gcloud config set project ${PROJECT_ID}
```

##### Set Compute Zone

```
gcloud config set compute/zone asia-east1-a
```


#### Create GKE Cluster

```
$ gcloud container clusters create cluster-1
Creating cluster cluster-1...done.
Created [https://container.googleapis.com/v1/projects/amihan-151906/zones/asia-east1-c/clusters/cluster-1].
kubeconfig entry generated for cluster-1.
NAME       ZONE          MASTER_VERSION  MASTER_IP        MACHINE_TYPE   NODE_VERSION  NUM_NODES  STATUS
cluster-1  asia-east1-c  1.5.3           104.199.205.191  n1-standard-1  1.5.3         3          RUNNING
```

#### Configure `kubectl` to connect to the new cluster

```
gcloud container clusters get-credentials cluster-1
```

##### Create a namespace

```
kubectl create namespace ${mynamespace}
```

##### Use that namespace

```
kubectl config set-context $(kubectl config current-context) --namespace=${mynamespace}
```

