# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  
  # validar quantidade de memoria no host

  # WpqF7W3xPDNkz39


  
  
  config.vm.provider "virtualbox" do |v|
    v.memory = 6144
    v.cpus = 6
  end

  config.vm.define "git_lab", primary:true do |web|
    web.vm.hostname = "git-lab"
    web.vm.box = "ubuntu/xenial64"
    web.vm.network "private_network", ip: "192.168.1.3", hostname: true
    
    web.vm.provision 'install git-lab', type:"ansible_local"do |ansible|
      ansible.playbook = "playbooks-ansible/git-lab.yml"
    end
    
    web.vm.provision 'install git-lab-runner', type:"ansible_local" do |ansible|
      ansible.playbook = "playbooks-ansible/git-lab-runner.yml"
    end
  end 
  
  config.vm.define "k8s_main", primary:true do |web|
    web.vm.hostname = "k8s-web-main"
    web.vm.box = "ubuntu/xenial64"
    web.vm.network "private_network", ip: "192.168.1.2", hostname: true
    web.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "playbooks-ansible/k8s-master-playbook.yml"
      ansible.extra_vars = {
          node_ip: "192.168.1.2",
      }
    end

  end

(1..2).each do |machine_id|
  config.vm.define "k8s_node_#{machine_id}" do |api|
    api.vm.hostname = "k8s-api-node#{machine_id}"
    api.vm.box = "ubuntu/xenial64"
    api.vm.network "private_network", ip: "192.168.1.#{10+machine_id}", hostname: true
    api.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "playbooks-ansible/k8s-node-playbook.yml"
      ansible.extra_vars = {
          node_ip: "192.168.1.#{10+machine_id}",
      }
    end
  end
end


  


  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
