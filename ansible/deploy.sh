#!/bin/bash

#ansible-playbook -i hosts deploy-terraform.yaml
#ansible-playbook -i hosts create-user.yaml
#ansible-inventory -vvvvvv -i hosts_info.yaml --list
ansible-playbook -i hosts clone-repo.yaml
ansible-playbook -i hosts deploy-common.yaml
ansible-playbook -i hosts deploy-docker.yaml
ansible-playbook -i master deploy-k8s.yaml