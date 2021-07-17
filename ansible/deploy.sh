#!/bin/bash

ansible-playbook -i hosts deploy-terraform.yaml
ansible-playbook -i hosts -l vm-worker01 deploy-docker.yaml
ansible-playbook -i hosts -l vm-master deploy-k8s.yaml