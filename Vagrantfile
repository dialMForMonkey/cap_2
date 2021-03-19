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
  # trocar essa /home
  path_rsa = File.expand_path("~/.ssh/id_rsa.pub")
  public_key =   File.read(path_rsa)
  
  config.vm.define "k8s_main", primary:true do |web|
    web.vm.hostname = "k8swebmain"
    web.ssh.insert_key = false
    web.vm.box = "ubuntu/xenial64"
    web.vm.network "private_network", ip: "192.168.1.2", hostname: true
    web.ssh.forward_agent = true
    
    web.vm.provision "file",  source:  path_rsa, destination: "/home/vagrant/.ssh/id_rsa"
    web.vm.provision :shell, :inline =>"
    echo 'Copying ansible-vm public SSH Keys to the VM'
    mkdir -p /home/vagrant/.ssh
    chmod 700 /home/vagrant/.ssh
    echo '#{public_key}' >> /home/vagrant/.ssh/authorized_keys
    chmod -R 600 /home/vagrant/.ssh/authorized_keys
    echo 'Host 192.168.*.*' >> /home/vagrant/.ssh/config
    echo 'StrictHostKeyChecking no' >> /home/vagrant/.ssh/config
    echo 'UserKnownHostsFile /dev/null' >> /home/vagrant/.ssh/config
    chmod -R 600 /home/vagrant/.ssh/config
    ", privileged: false
    web.vm.provision "shell", path: "./install_config_ansible.sh",  privileged: true
  end

(1..2).each do |machine_id|
  config.vm.define "k8s_node_#{machine_id}" do |api|
    api.vm.hostname = "k8sapinode#{machine_id}"
    api.ssh.insert_key = false
    api.vm.box = "ubuntu/xenial64"
    api.vm.provision "file", source:   path_rsa, destination: "/home/vagrant/.ssh/id_rsa"
    api.vm.network "private_network", ip: "192.168.1.#{10+machine_id}", hostname: true
    api.ssh.forward_agent = true
    api.vm.provision :shell, :inline =>"
    echo 'Copying ansible-vm public SSH Keys to the VM'
    mkdir -p /home/vagrant/.ssh
    chmod 700 /home/vagrant/.ssh
    echo '#{public_key}' >> /home/vagrant/.ssh/authorized_keys
    chmod -R 600 /home/vagrant/.ssh/authorized_keys
    echo 'Host 192.168.*.*' >> /home/vagrant/.ssh/config
    echo 'StrictHostKeyChecking no' >> /home/vagrant/.ssh/config
    echo 'UserKnownHostsFile /dev/null' >> /home/vagrant/.ssh/config
    chmod -R 600 /home/vagrant/.ssh/config
    ", privileged: false
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
