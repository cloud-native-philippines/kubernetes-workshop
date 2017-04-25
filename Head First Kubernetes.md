Head First Kubernetes
====

## Head First Docker

## Why Kubernetes?

## Getting Started

#### MacOS Requirements & Installation

* Virtualbox
* Homebrew
* Vagrant

##### Note to Mac OS and Vagrant users

You might need to 

```
sudo ln -sf /usr/local/bin/openssl /opt/vagrant/embedded/bin/openssl
```

For Vagrant to work correctly. See https://github.com/mitchellh/vagrant/issues/7747

### Kubectl

```
$ brew install kubectl
```


### Minikube

> Minikube is a tool that makes it easy to run Kubernetes locally. Minikube runs a single-node Kubernetes cluster inside a VM on your laptop for users looking to try out Kubernetes or develop with it day-to-day.

#### Requirements & Installation

##### MacOS

```
$ brew cask install minikube
```

#### Usage

```
$ minikube start
Starting local Kubernetes cluster...
Downloading Minikube ISO
 84.07 MB / 84.07 MB [==============================================] 100.00% 0s
Kubectl is now configured to use the cluster.
```

Check to see if `kubectl` is working.

```
$ kubectl get namespaces
NAME          STATUS    AGE
default       Active    5m
kube-system   Active    5m
```

### CoreOS + Vagrant

#### Requirements & Installation

```
$ git clone https://github.com/coreos/coreos-kubernetes
$ cd coreos-kubernetes/multi-node/vagrant
$ vagrant up
```

```
$ export KUBECONFIG="${KUBECONFIG}:$(pwd)/kubeconfig"
$ kubectl config use-context vagrant-multi
```

Might need to wait a few minutes before

```
$ kubectl get nodes
```

### Kargo + Vagrant (default)

#### Requirements & Installation

```
$ git clone https://github.com/kubernetes-incubator/kargo.git
$ cd kargo
$ vagrant up
```

Might need to wait a few minutes before

```
$ vagrant ssh k8s-01
```

Then

```
vagrant@k8s-01:~$ kubectl get nodes
```

### Kargo + Vagrant (scratch)

```
$ pip install kargo
```

Might need to 

```
$ pip install --upgrade jinja2
```

Get a default `kargo.yaml`

```
$ wget https://raw.githubusercontent.com/kubespray/kargo-cli/master/src/kargo/files/kargo.yml
```

Create Vagrantfile, boot up VMs

```
$ vagrant up
```

Create Ansible inventory file

```
$ cp inventory.cfg ~/.kargo/inventory
```

Use Kargo to deploy (takes a while)

```
kargo deploy -y --config kargo.yml
```

## Deploying Applications on to Kubernetes

```
kubectl create -f https://raw.githubusercontent.com/kubernetes/kubernetes/master/examples/guestbook/all-in-one/guestbook-all-in-one.yaml
```

### Creating Custom Deployments



## Helm

`