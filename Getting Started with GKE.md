Getting Started - GKE
====

##### Table of Contents

* GCP Cloud SDK setup
* Kubernetes setup

## GCP Cloud SDK Setup

### Install the Google Cloud SDK

#### Mac OS

Prerequisites:

* Homebrew

Install GCP Cloud SDK using Homebrew:

```bash
brew cask install google-cloud-sdk
```

#### Ubuntu

Follow the instructions at [https://cloud.google.com/sdk/downloads#apt-get](https://cloud.google.com/sdk/downloads#apt-get):

Create an environment variable for the correct distribution:

```bash
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
```

Add the Cloud SDK distribution URI as a package source:

```bash
echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
```

Import the Google Cloud public key:

```bash
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
```

Update and install the Cloud SDK:

```bash
sudo apt-get update && sudo apt-get install google-cloud-sdk
```

### Setup `gcloud` CLI tool

#### Authenticate with GCP

```bash
gcloud init
```

This will open up a browser window where you are expected to authenticate using your Google account.

#### Configure `gcloud`

Once authenticated, verify the default compute region and zone:

```bash
gcloud config get-value compute/region
gcloud config get-value compute/zone
```

The default region and zone should be `asia-southeast1` and `asia-southeast1-b`, respectively. If your defaults are not set or are different, set them to `asia-southeast1` and `asia-southeast1-b`:

```bash
gcloud config set compute/region asia-southeast1
gcloud config set compute/zone asia-southeast1-b
```

##### (Optional) Create a project

```bash
gcloud projects create amihan-kates --name amihan-kates --organization agsx.net --set-as-default
```

Set your default project to, e.g. `amihan-kates`:

```bash
gcloud config set project amihan-kates
```

#### (Optional) Create a cluster

The following creates a 

```bash
gcloud container clusters create "tweeter" --num-nodes "1" --cluster-version "1.6.4" \
--zone "asia-southeast1-a" --additional-zones "asia-southeast1-b"
```

## GKE and `kubectl`

### Install `kubectl`

#### Mac OS

```bash
brew install kubectl
```

#### Ubuntu

Download as part of the Google Cloud SDK:

```bash
gcloud components install kubectl
```

Or follow the instructions at [https://kubernetes.io/docs/tasks/kubectl/install/#install-kubectl-binary-via-curl](https://kubernetes.io/docs/tasks/kubectl/install/#install-kubectl-binary-via-curl)

### Configure `kubectl` credentials

Obtain `kubectl` credentials for your GKE cluster:

```bash
gcloud container clusters get-credentials tweeter
```

If you have used `kubectl` with other clusters before, make sure that the correct context is selected:

```bash
kubectl config use-context gke_amihan-kates_asia-southeast1-b_tweeter
```

##### Create a namespace

Create a namespace, e.g. `tweeter`:

```bash
kubectl create namespace tweeter
```

Set the default namespace to `tweeter`:

```bash
kubectl config set-context gke_amihan-kates_asia-southeast1-b_tweeter --namespace=tweeter
```

Verify that everything is working:

```bash
$ kubectl cluster-info
```

#### Kubernetes Dashboard

To see the Kubernetes dashboard, it is necessary to open a proxy to the cluster:

```bash
kubectl proxy
```

Afterwards, the dashboard should be availabe at [http://localhost:8001/ui](http://localhost:8001/ui)
