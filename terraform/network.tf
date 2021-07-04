# Create a network for the machines
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

# Create a subnet for the previous network
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
resource "azurerm_subnet" "mySubnetEnv" {
    name                   = "terraformsubnet"
    resource_group_name    = azurerm_resource_group.rg.name
    virtual_network_name   = azurerm_virtual_network.myNet.name #the name of the net whithin this subnet is built
    address_prefixes       = ["10.0.1.0/24"]
}

# Public IP creation for each machine. 
# As the IPs are created recursively this code has been moved before the network interface (NIC) creation to be used
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip
resource "azurerm_public_ip" "myPublicIp" {
  count               = length(var.vms) #iterate among the length of the variable vms to create one public IP for each machine
  name                = "vm-${var.vms[count.index]}" #create a name for each IP
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
    tags = {
        environment = "CP2"
    }

}

# Create network interface (NIC) for each machine and assign a private and public IP
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface
resource "azurerm_network_interface" "myNic" {
  count               = length(var.vms) #iterate among the length of the variable vms to assign private and public IP to each
  name                = "vmnic-${var.vms[count.index]}" #create a name to each NIC
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
      name                           = "ipconfig-${var.vms[count.index]}"
      subnet_id                      = azurerm_subnet.mySubnetEnv.id
      private_ip_address_allocation  = "Static"
      private_ip_address             = "10.0.1.${count.index+10}" #asign the static IP     
      public_ip_address_id           =  azurerm_public_ip.myPublicIp[count.index].id #public IP
  }

    tags = {
        environment = "CP2"
    }

}

