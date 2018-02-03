Kubernetes 101
====

### Prerequisites

#### macOS

##### Install Homebrew 

See [https://brew.sh](https://brew.sh)

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### minikube

#### Installation

##### macOS

```
brew cask install minikube
```

#### Start minikube

```
minikube start --memory 4096
```

Wait for the dashboard to become available

```
minikube dashboard
```

### `kubectl`

#### Installation

##### macOS

```
brew install kubernetes-cli
```

### Helm

#### Installation

##### macOS

```
brew install kubernetes-helm
```

#### Initialize Helm on to your Kubernetes cluster

```
helm init
```

