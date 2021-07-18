#!/bin/bash

#ansible-playbook -i hosts deploy-terraform.yaml
#ansible-playbook -i hosts create-user.yaml
#ansible-inventory -vvvvvv -i hosts_info.yaml --list
ansible-playbook -i hosts -l nfs-node clone-repo.yaml
ansible-playbook -i hosts -l nfs-node deploy-common.yaml
ansible-playbook -i hosts -l nfs-node deploy-docker.yaml
ansible-playbook -i master deploy-k8s.yaml