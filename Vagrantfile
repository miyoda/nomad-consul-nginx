# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  1.upto(6) do |i|
    config.vm.define "cluster#{i}" do |cluster|
      cluster.vm.box = "centos/7"
      cluster.vm.network "private_network", ip: "192.168.10.1#{i}"

      cluster.vm.provider "virtualbox" do |vb|
        vb.memory = 1024
        vb.cpus = 1
      end

      cluster.vm.provision :ansible do |ansible|
        ansible.verbose = "v"
        ansible.playbook = "nomad.yml"
        ansible.inventory_path = "inventory"
      end
    end
  end

end
