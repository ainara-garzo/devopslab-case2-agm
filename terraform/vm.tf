# Creamos una máquina virtual
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine

resource "azurerm_linux_virtual_machine" "myVM1" {
    count               = length(var.vms)
    name                = "vm-${var.vms[count.index]}" #iterate among the length of the variable vms, where master, 2 workers and nfs have been defined
    resource_group_name = azurerm_resource_group.rg.name
    location            = var.location
    size                = var.vm_size #virtual machine size defined in vars.tf
    admin_username      = "adminUsername"
    network_interface_ids = [ azurerm_network_interface.myNic[count.index].id ] #list of networks
    disable_password_authentication = true #password identification is deactivated, to use public/private password identification via ssh

    admin_ssh_key {
        username   = var.ssh_user
        public_key = file(var.public_key_path)
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    plan {
        name      = "centos-8-stream-free" 
        product   = "centos-8-stream-free"
        publisher = "cognosys"
    }

    #OS image used
    source_image_reference {
        publisher = "cognosys"
        offer     = "centos-8-stream-free"
        sku       = "centos-8-stream-free"
        version   = "1.2019.0810"
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.stAccount.primary_blob_endpoint
    }

    tags = {
        environment = "CP2"
    }

}