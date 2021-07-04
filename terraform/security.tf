# Security group definition
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group
resource "azurerm_network_security_group" "mySecGroup" {
    name                = "sshtraffic" #place to site it
    location            = var.location
    resource_group_name = azurerm_resource_group.rg.name
    #any traffict that comes through 22 port will be allowed
    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"  
        destination_port_range     = "22" 
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "CP2"
    }
}

# Assign the security group to the network interface
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association
resource "azurerm_network_interface_security_group_association" "mySecGroupAssociation1" {
    count                       = length(var.vms)
    network_interface_id        = azurerm_network_interface.myNic[count.index].id #related to the network myNic defined in network.tf
    network_security_group_id   = azurerm_network_security_group.mySecGroup.id #assigned to mySecGroup

}
