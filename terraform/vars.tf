#Variable to define the Region where the infrastructure has been created in Azure
variable "location" {
  type = string
  description = "Region where the infrastructure has been created in Azure"
  default = "West Europe"
}

#Variable to define the VM machine size
variable "master_size" {
  type = string
  description = "Vitual machine size"
  default = "Standard_D2s_v3" #8 GB, 2 CPU
}

variable "vm_size" {
  type = string
  description = "Vitual machine size"
  default = "Standard_D1_v2" # 3.5 GB, 1 CPU 
}

#Variable to define different machines in the system
variable "vms" {
  type = list(string)
  description = "Vitual machine names"
  default = ["master", "worker01", "worker02"]
}

#Variable to define different nodes
#variable "nodes" {
#  type = list(string)
#  description = "vms nodes"
#  default = ["node1", "node2"]
#}
