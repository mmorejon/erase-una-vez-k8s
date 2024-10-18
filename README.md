# Érase una vez Kubernetes

Repositorio de ejercicios y ejemplos utilizados en el libro [Érase una vez Kubernetes](https://leanpub.com/erase-una-vez-kubernetes).

## ⚠️ Importante

Ha sido cambiado el distribución del cluster utilizada en el libro de [Vagrant](https://www.vagrantup.com)+[Kubeadmin](https://kubernetes.io/docs/reference/setup-tools/kubeadm/) a [Kind](https://kind.sigs.k8s.io/). Se recomienda a los lectores a utilizar la distribución Kind. Las configuraciones utilizadas con Vagrant se encuentran en la rama [v1.x](https://github.com/mmorejon/erase-una-vez-k8s/tree/v1.x).

| Rama | Distribución |
| - | - |
| `main`, `v2.x` | (Recomendada) Utiliza Kind para gestionar el cluster |
| `v1.x` | Utiliza VirtualBox + Vagrant + Kubeadmin para gestionar el cluster |

## Características del cluster

El cluster de Kubernetes utilizado en el libro cuenta con:

* 1 control-plane
* 2 workers

### Requisitos previos

* Tener instalado [Docker](https://docs.docker.com/get-docker/)  `>= 27.2.0`
* Tener instalado [Kubectl](https://kubernetes.io/es/docs/tasks/tools/install-kubectl/) `1.31.1`
* Tener instalado [Kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation) `v0.24.0`

### Crear cluster

Las configuraciones del cluster se encuentran en el fichero `cluster/kind-config.yaml`.

```bash
git clone https://github.com/mmorejon/erase-una-vez-k8s.git && \
  cd erase-una-vez-k8s && \
  bash/cluster.sh create
```

<details>
  <summary>Resultado</summary>

  ```
  Creating cluster "book" ...
  ✓ Ensuring node image (kindest/node:v1.31.1) 🖼
  ✓ Preparing nodes 📦 📦 📦
  ✓ Writing configuration 📜
  ✓ Starting control-plane 🕹️
  ✓ Installing CNI 🔌
  ✓ Installing StorageClass 💾
  ✓ Joining worker nodes 🚜
  Set kubectl context to "kind-book"
  You can now use your cluster with:

  kubectl cluster-info --context kind-book

  Have a nice day! 👋
  ```
</details>

## Sugerencias y Comentarios

Déjanos saber lo que estás pensando sobre el libro [Érase una vez Kubernetes](https://leanpub.com/erase-una-vez-kubernetes). Al igual que en los libros de cuentos, haremos todo lo posible por cumplir tu sueños!
