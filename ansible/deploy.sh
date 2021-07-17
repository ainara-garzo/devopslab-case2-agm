#!/bin/bash

#ansible-playbook -i hosts clone-repo.yaml
ansible-playbook -i hosts deploy-terraform.yaml
sudo apt-get install sshpass
ansible-playbook -i hosts deploy-common.yaml
ansible-playbook -i hosts deploy-docker.yaml
ansible-playbook -i master deploy-k8s.yaml