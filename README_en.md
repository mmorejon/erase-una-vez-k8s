# Once Upon a Time Kubernetes

Repository containing exercises and examples from the book [Once Upon a Time Kubernetes](https://leanpub.com/once-upon-a-time-kubernetes).

Traducción: [Español](README.md)

## ⚠️ Important

The cluster distribution used in the book has been changed from [Vagrant](https://www.vagrantup.com)+[Kubeadmin](https://kubernetes.io/docs/reference/setup-tools/kubeadm/) to [Kind](https://kind.sigs.k8s.io/). We recommend that readers use the Kind distribution. The configurations used with Vagrant can be found in the [v1.x](https://github.com/mmorejon/erase-una-vez-k8s/tree/v1.x) branch.

| Branch | Distribution |
| - | - |
| `main`, `v2.x` | (Recommended) Uses Kind to manage the cluster |
| `v1.x` | Uses VirtualBox + Vagrant + Kubeadmin to manage the cluster |

## Cluster Features

The Kubernetes cluster described in the book includes:

* 1 control-plane
* 2 workers

### Prerequisites

* Have [Docker](https://docs.docker.com/get-docker/) installed `>= 27.2.0`
* Have [Kubectl](https://kubernetes.io/docs/tasks/tools/) installed `1.31.1`
* Have [Kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation) installed `v0.26.0`

### Create Cluster

The cluster configurations are found in the `cluster/kind-config.yaml` file.

```bash
git clone https://github.com/mmorejon/erase-una-vez-k8s.git && \
  cd erase-una-vez-k8s && \
  bash/cluster.sh create
```

<details>
  <summary>Result</summary>

  ```
  Creating cluster "book" ...
  ✓ Ensuring node image (kindest/node:v1.32.1) 🖼
  ✓ Preparing nodes 📦 📦 📦
  ✓ Writing configuration 📜
  ✓ Starting control-plane 🕹️
  ✓ Installing CNI 🔌
  ✓ Installing StorageClass 💾
  ✓ Joining worker nodes 🚜
  Set kubectl context to "kind-book"
  You can now use your cluster with:

  kubectl cluster-info --context kind-book

  Have a question, bug, or feature request? Let us know! https://kind.sigs.k8s.io/#community 🙂
  ```
</details>

## Suggestions and Comments

We'd love to hear your thoughts on the book [Once Upon a Time Kubernetes](https://leanpub.com/once-upon-a-time-kubernetes). Just like in fairy tales, we're here to help make your dreams come true!
