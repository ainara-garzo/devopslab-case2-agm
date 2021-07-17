#!/bin/bash

ansible-playbook -i deploy-terraform.yaml
#ansible-playbook -i hosts -l XXXX playbook
ansible-playbook -i master -l deploy-k8s.yaml
ansible-playbook -i deploy-deploy.yaml