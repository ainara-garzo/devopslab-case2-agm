# Creación de red
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network

resource "azurerm_virtual_network" "myNet" {
    name                = "kubernetesnet"
    address_space       = ["10.0.0.0/16"]
    location            = var.location
    resource_group_name = azurerm_resource_group.rg.name

    tags = {
        environment = "CP2"
    }
}

# Creación de subnet
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet

resource "azurerm_subnet" "mySubnetEnv" {
    count                  = length(var.net_envs) #iterate among the length of the variable net_envs
    name                   = "terraformsubnet-${var.net_envs[count.index]}" #network name will change adding in the name of each defined environment in net_envs
    resource_group_name    = azurerm_resource_group.rg.name
    virtual_network_name   = azurerm_virtual_network.myNet.name #the name of the net whithin this subnet is built
    address_prefixes       = ["10.0.${100+count.index}.0/24"] 

}

# Create NIC
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface

resource "azurerm_network_interface" "myNic1" {
  count               = length(var.vms) #iterate among the length of the variable vms, where master, worker and nfs have been defined
  name                = "vmnic-${var.vms[count.index]}"  
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
      name                           = "ipconfig-${var.vms[count.index]}"
      subnet_id                      = azurerm_subnet.mySubnetEnv[count.index].id
      private_ip_address_allocation  = "Static"
      private_ip_address             = "10.0.${azurerm_subnet.mySubnetEnv[count.index].count.index+100}.${count.index+1}" #static IP 
      public_ip_address_id           = azurerm_public_ip.myPublicIp1[count.index].id #public IP
  }

    tags = {
        environment = "CP2"
    }

}

# Public IP
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip

resource "azurerm_public_ip" "myPublicIp1" {
  count               = length(var.vms) #iterate among the length of the variable vms, where master, 2 workers and nfs have been defined
  name                = "vm-${var.vms[count.index]}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

    tags = {
        environment = "CP2"
    }

}