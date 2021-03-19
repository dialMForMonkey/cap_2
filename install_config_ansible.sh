#!/usr/bin/env bash
## install and config ansible 
sudo apt-add-repository ppa:ansible/ansible 
sudo apt-get update
sudo apt-get install ansible -y

sudo echo -e "\n[servers] \n k8sapinode1 ansible_ssh_host=192.168.1.11 \n k8sapinode2 ansible_ssh_host=192.168.1.12 \n" > /etc/ansible/hosts 

sudo mkdir /etc/ansible/group_vars
sudo echo "ansible_ssh_user: vagrant " > servers
