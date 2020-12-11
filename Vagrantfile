# -*- mode: ruby -*-
# vi: set ft=ruby :

## vagrant parameters
BOX = "bento/ubuntu-20.04"
BOX_VERSION = "202010.24.0"
# master node parameters
MASTER_IP = "192.168.100.10"
MASTER_CPU = "2"
MASTER_RAM = "2048"
# node parameters
NODE_IP = "192.168.100."
NODE_COUNT = 2
NODE_CPU = "1"
NODE_RAM = "1024"
# kubernetes parameters
KUBERNETES_VERSION = "1.19.3"
KUBEADM_TOKEN = "b0sybt.xpp56ac5a1medj3n"
# repository parameters
REPO_PATH = "/home/vagrant/erase-una-vez-k8s"

## general vagrant configurations
Vagrant.configure("2") do |config|
  config.vm.box = BOX
  config.vm.box_check_update = false
  config.vm.box_version = BOX_VERSION
  config.vm.provision "shell", :path => "bash/provision-base.sh",
    env: {
      "KUBERNETES_VERSION" => KUBERNETES_VERSION
    }

  # master node configuration
  config.vm.define "master" do |master|
    master.vm.hostname = "master"
    master.vm.network "private_network", ip: MASTER_IP
    master.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--cpus", MASTER_CPU]
      vb.customize ["modifyvm", :id, "--memory", MASTER_RAM]
    end
    master.vm.provision :shell, :path => "bash/provision-master.sh",
      env: {
        "KUBEADM_TOKEN" => KUBEADM_TOKEN,
        "MASTER_IP" => MASTER_IP,
        "KUBERNETES_VERSION" => KUBERNETES_VERSION,
        "REPO_PATH" => REPO_PATH
      }
    master.vm.provision :shell, :path => "bash/provision-load-balancer.sh",
      run: "always"
    master.vm.synced_folder "./", REPO_PATH
  end

  # node configuration
  (1..NODE_COUNT).each do |i|
    config.vm.define "node#{i}" do |node|
      node.vm.hostname = "node#{i}"
      node.vm.network "private_network", ip: NODE_IP + "#{i + 10}"
      node.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--cpus", NODE_CPU]
        vb.customize ["modifyvm", :id, "--memory", NODE_RAM]
      end
      node.vm.provision :shell, :path => "bash/provision-node.sh",
        env: {
          "KUBEADM_TOKEN" => KUBEADM_TOKEN,
          "MASTER_IP" => MASTER_IP
        }
    end
  end

end