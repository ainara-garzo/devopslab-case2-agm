sudo yum install -y http://mirror.centos.org/centos/7/extras/x86_64/Packages/sshpass-1.06-2.el7.x86_64.rpm
ansible localhost -m {{ rg_group }} -a {{ ansible_params }}
