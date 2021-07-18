devopslab-case2-agm Copyright (C) 2021  Ainara Garzo
This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.   

This is free software, and you are welcome to redistribute it
under certain conditions; type `show c' for details.

Caso práctico 2   

Virtual machine deploy using Terraform in './terraform'.   
'credentials.tf' file is needed where the following features must be defined for to deploy the machines in Azure:   
 - subscription_id
 - client_id
 - client_secret
 - tenant_id 

 It can be also deployed using the Ansible Playbook 'deploy-terraform.yaml'   

deploy Ansible playbooks using:  
> sh deploy.sh    

The following palaybooks will be deployed using the corresponding roles:
- create-user.yaml
- clone-repo.yaml
- deploy-common.yaml
- deploy-docker.yaml
- deploy-k8s.yaml
