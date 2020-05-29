# Érase una vez Kubernetes

Repositorio de ejercicios y ejemplos utilizados en el libro [Érase una vez Kubernetes](https://leanpub.com/erase-una-vez-kubernetes).

Para aprender y practicar Kubernetes hay que tener un cluster, y si este cluster tiene múltiples nodos será mucho mejor.

El cluster de Kubernetes utilizado en el libro cuenta con:

* 1 nodo master v1.18.3
* 2 nodos
* [Calico](https://www.projectcalico.org) para las comunicaciones y políticas de red

## Requisitos previos

* Tener instalado [VirtualBox](https://www.virtualbox.org/wiki/Downloads)  `>= 6.1.8`
* Tener instalado [Vagrant](https://www.vagrantup.com/downloads.html) `>= 2.2.9`

## Configuración del cluster

Puede adaptar el cluster a sus necesidades a través de las variables establecidas en el fichero `Vagrantfile`.

```bash
# master node parameters
MASTER_CPU = "2"
MASTER_RAM = "2048"
# node parameters
NODE_COUNT = 2
NODE_CPU = "1"
NODE_RAM = "1024"
# kubernetes parameters
KUBERNETES_VERSION = "1.18.3"
```

## Instalación

Clone el repositorio `git` con el contenido del curso y acceda a la carpeta la carpeta descargada.

```bash
git clone --depth=1 https://github.com/mmorejon/erase-una-vez-k8s.git

cd erase-una-vez-k8s
```

Inicie la creación del cluster utilizando el siguiente comando de Vagrant:

```bash
vagrant up
```

La construcción del cluster demora aproximadamente 5 minutos. El tiempo puede variar en dependencia de la velocidad de red.

### Video de la instalación

[![asciicast](https://asciinema.org/a/318782.svg)](https://asciinema.org/a/318782)

## Practicar dentro del nodo master

Con el objetivo de acelerar el aprendizaje de Kubernetes sugerimos realizar todos los ejercicios dentro del nodo master del cluster. Este nodo ha sido configurado con los sistemas que necesita para empezar (p.ej, `kubectl` y fichero `config`), pero sobre todo, evita posibles errores derivados de las configuraciones que actualmente existen en su ordenador.

Dentro del nodo master se encuentra sincronizado el directorio `git` con todos los ejercicios. De esta forma podrá modificar o crear nuevos ejemplos desde su editor preferido (p.ej [VSCode](https://code.visualstudio.com)) y los cambios se reflejarán al instante dentro del nodo master.

Acceda al nodo master que se ha creado

```bash
vagrant ssh master
```

y compruebe el estado del cluster.

```bash
kubectl get nodes
```

Deberá obtener un resultado similar al siguiente:

```bash
NAME     STATUS   ROLES    AGE     VERSION
master   Ready    master   7m37s   v1.18.3
node1    Ready    <none>   5m8s    v1.18.3
node2    Ready    <none>   2m46s   v1.18.3
```

## Practicar fuera del nodo master

Puede conectarse al cluster desde cualquier carpeta del ordenador. Para lograrlo siga los siguientes pasos:

Instale el componente `vagrant-scp` a través del comando:

```bash
vagrant plugin install vagrant-scp
```

Liste las máquinas virtuales que ha creado Vagrant para obtener el identificador del nodo master

```bash
vagrant global-status

id       name   provider   state   directory
-----------------------------------------------------------
d407cfe  master virtualbox running /...../erase-una-vez-k8s
26b02fc  node1  virtualbox running /...../erase-una-vez-k8s
7fbe26d  node2  virtualbox running /...../erase-una-vez-k8s
```

Copie el fichero de configuración de Kubernetes desde el nodo master hacia el directorio `HOME` de su usuario. Si actualmente existe el fichero `~/.kube/config` le sugerimos que realice una copia del fichero antes de modificarlo.

## Sugerencias y Comentarios

Déjanos saber lo que estás pensando sobre el libro [Érase una vez Kubernetes](https://leanpub.com/erase-una-vez-kubernetes). Al igual que en los libros de cuentos, haremos todo lo posible por cumplir tu sueños!
