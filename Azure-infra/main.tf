provider "azurerm" {
  features {
    virtual_machine_scale_set {
      force_delete = false
      roll_instances_when_required = true
      scale_to_zero_before_deletion = true
    }
    

  }
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}


# provider "azurerm" {
#   features {}
# }

# # Resource Group
# resource "azurerm_resource_group" "main_rg" {
#   name     = var.resource_group_name
#   location = var.location
# }

# # Virtual Network
# resource "azurerm_virtual_network" "main_vnet" {
#   name                = var.vnet_name
#   address_space       = [var.vnet_address_space]
#   location            = azurerm_resource_group.main_rg.location
#   resource_group_name = azurerm_resource_group.main_rg.name
# }

# # Subnet 1
# resource "azurerm_subnet" "subnet_1" {
#   name                 = "subnet_1"
#   resource_group_name  = azurerm_resource_group.main_rg.name
#   virtual_network_name = azurerm_virtual_network.main_vnet.name
#   address_prefixes     = [var.subnet_1_cidr]
# }

# # Subnet 2
# resource "azurerm_subnet" "subnet_2" {
#   name                 = "subnet_2"
#   resource_group_name  = azurerm_resource_group.main_rg.name
#   virtual_network_name = azurerm_virtual_network.main_vnet.name
#   address_prefixes     = [var.subnet_2_cidr]
# }

# # Network Security Group for VM1
# resource "azurerm_network_security_group" "nsg_vm1" {
#   name                = "nsg-vm1"
#   location            = azurerm_resource_group.main_rg.location
#   resource_group_name = azurerm_resource_group.main_rg.name

#   security_rule {
#     name                       = "Allow-SSH-HTTP"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_ranges    = ["22", "80"]
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
# }

# # Network Security Group for VM2
# resource "azurerm_network_security_group" "nsg_vm2" {
#   name                = "nsg-vm2"
#   location            = azurerm_resource_group.main_rg.location
#   resource_group_name = azurerm_resource_group.main_rg.name

#   security_rule {
#     name                       = "Allow-SSH-HTTP"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_ranges    = ["22", "80"]
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
# }

# # Network Interface for VM1
# resource "azurerm_network_interface" "nic_vm1" {
#   name                = "nic-vm1"
#   location            = azurerm_resource_group.main_rg.location
#   resource_group_name = azurerm_resource_group.main_rg.name

#   ip_configuration {
#     name                          = "ipconfig1"
#     subnet_id                     = azurerm_subnet.subnet_1.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.pip_vm1.id
#   }
# }

# # Network Interface for VM2
# resource "azurerm_network_interface" "nic_vm2" {
#   name                = "nic-vm2"
#   location            = azurerm_resource_group.main_rg.location
#   resource_group_name = azurerm_resource_group.main_rg.name

#   ip_configuration {
#     name                          = "ipconfig1"
#     subnet_id                     = azurerm_subnet.subnet_2.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.pip_vm2.id
#   }
# }

# # Public IP for VM1
# resource "azurerm_public_ip" "pip_vm1" {
#   name                = "pip-vm1"
#   location            = azurerm_resource_group.main_rg.location
#   resource_group_name = azurerm_resource_group.main_rg.name
#   allocation_method   = "Dynamic"
# }

# # Public IP for VM2
# resource "azurerm_public_ip" "pip_vm2" {
#   name                = "pip-vm2"
#   location            = azurerm_resource_group.main_rg.location
#   resource_group_name = azurerm_resource_group.main_rg.name
#   allocation_method   = "Dynamic"
# }

# # Virtual Machine 1
# resource "azurerm_linux_virtual_machine" "vm1" {
#   name                = "vm1"
#   location            = azurerm_resource_group.main_rg.location
#   resource_group_name = azurerm_resource_group.main_rg.name
#   network_interface_ids = [azurerm_network_interface.nic_vm1.id]
#   size                = var.vm_size

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "18.04-LTS"
#     version   = "latest"
#   }

#   computer_name                   = "vm1"
#   admin_username                  = var.admin_username
#   admin_password                  = var.admin_password
#   disable_password_authentication = false

#   tags = {
#     environment = "Terraform"
#   }
# }

# # Virtual Machine 2
# resource "azurerm_linux_virtual_machine" "vm2" {
#   name                = "vm2"
#   location            = azurerm_resource_group.main_rg.location
#   resource_group_name = azurerm_resource_group.main_rg.name
#   network_interface_ids = [azurerm_network_interface.nic_vm2.id]
#   size                = var.vm_size

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "18.04-LTS"
#     version   = "latest"
#   }

#   computer_name                   = "vm2"
#   admin_username                  = var.admin_username
#   admin_password                  = var.admin_password
#   disable_password_authentication = false

#   tags = {
#     environment = "Terraform"
#   }
# }

# # Associate NSG with Network Interfaces
# resource "azurerm_network_interface_security_group_association" "nsg_assoc_vm1" {
#   network_interface_id      = azurerm_network_interface.nic_vm1.id
#   network_security_group_id = azurerm_network_security_group.nsg_vm1.id
# }

# resource "azurerm_network_interface_security_group_association" "nsg_assoc_vm2" {
#   network_interface_id      = azurerm_network_interface.nic_vm2.id
#   network_security_group_id = azurerm_network_security_group.nsg_vm2.id
# }





# locals {
#   data_input = {
#     heading_one = var.heading_one
#   }
# }





# # Network Interface for VM1
# resource "azurerm_network_interface" "nic_vm1" {
#   name                = "nic-vm1"
#   location            = azurerm_resource_group.main_rg.location
#   resource_group_name = azurerm_resource_group.main_rg.name
#   ip_configuration {
#     name                          = "ipconfig1"
#     subnet_id                     = azurerm_subnet.subnet_1.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.pip_vm1.id
#   }
# }

# # Network Interface for VM2
# resource "azurerm_network_interface" "nic_vm2" {
#   name                = "nic-vm2"
#   location            = azurerm_resource_group.main_rg.location
#   resource_group_name = azurerm_resource_group.main_rg.name

#   ip_configuration {
#     name                          = "ipconfig1"
#     subnet_id                     = azurerm_subnet.subnet_2.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.pip_vm2.id
#     availability_zone             = "1"
#   }
# }

# # Public IP for VM1
# resource "azurerm_public_ip" "pip_vm1" {
#   name                = "pip-vm1"
#   location            = azurerm_resource_group.main_rg.location
#   resource_group_name = azurerm_resource_group.main_rg.name
#   allocation_method   = "Dynamic"
#   sku                 = "Standard"
# }

# # Public IP for VM2
# resource "azurerm_public_ip" "pip_vm2" {
#   name                = "pip-vm2"
#   location            = azurerm_resource_group.main_rg.location
#   resource_group_name = azurerm_resource_group.main_rg.name
#   allocation_method   = "Dynamic"
#   sku                 = "Standard"
# }

# Virtual Machine 1
# resource "azurerm_linux_virtual_machine" "vm1" {
#   name                = "vm1"
#   location            = azurerm_resource_group.main_rg.location
#   resource_group_name = azurerm_resource_group.main_rg.name
#   network_interface_ids = [azurerm_network_interface.nic_vm1.id]
#   size                = var.vm_size

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "18.04-LTS"
#     version   = "latest"
#   }

#   computer_name                   = "vm1"
#   admin_username                  = var.admin_username
#   admin_password                  = var.admin_password
#   disable_password_authentication = false

#   tags = {
#     environment = "Terraform"
#   }
# }

# # Virtual Machine 2
# resource "azurerm_linux_virtual_machine" "vm2" {
#   name                = "vm2"
#   location            = azurerm_resource_group.main_rg.location
#   resource_group_name = azurerm_resource_group.main_rg.name
#   network_interface_ids = [azurerm_network_interface.nic_vm2.id]
#   size                = var.vm_size

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "18.04-LTS"
#     version   = "latest"
#   }

#   computer_name                   = "vm2"
#   admin_username                  = var.admin_username
#   admin_password                  = var.admin_password
#   disable_password_authentication = false

#   tags = {
#     environment = "Terraform"
#   }
# }

# Associate NSG with Network Interfaces
# resource "azurerm_network_interface_security_group_association" "nsg_assoc_vm1" {
#   network_interface_id      = azurerm_network_interface.nic_vm1.id
#   network_security_group_id = azurerm_network_security_group.nsg_vm1.id
# }

# resource "azurerm_network_interface_security_group_association" "nsg_assoc_vm2" {
#   network_interface_id      = azurerm_network_interface.nic_vm2.id
#   network_security_group_id = azurerm_network_security_group.nsg_vm2.id
# }

# Adding VMs to the Backend Address Pool of the Load Balancer
# resource "azurerm_network_interface_backend_address_pool_association" "vm1_to_frontend_bap" {
#   network_interface_id    = azurerm_network_interface.nic_vm1.id
#   ip_configuration_name   = "ipconfig1"
#   backend_address_pool_id = azurerm_lb_backend_address_pool.frontend_bap.id
# }

# resource "azurerm_network_interface_backend_address_pool_association" "vm2_to_backend_bap" {
#   network_interface_id    = azurerm_network_interface.nic_vm2.id
#   ip_configuration_name   = "ipconfig1"
#   backend_address_pool_id = azurerm_lb_backend_address_pool.backend_bap.id
# }




# resource "azurerm_linux_virtual_machine_scale_set" "backend_vmss" {
#   name                = "backend-vmss"
#   location            = azurerm_resource_group.main_rg.location
#   resource_group_name = azurerm_resource_group.main_rg.name


#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }
#   network_interface {
#     name                      = "backend-nic"
#     primary                   = true
#     network_security_group_id = azurerm_network_security_group.nsg_vm2.id
#     ip_configuration {
#       name      = "backend-ip-config"
#       subnet_id = azurerm_subnet.subnet_2.id
#       load_balancer_backend_address_pool_ids = [
#         azurerm_lb_backend_address_pool.backend_bap.id
#       ]
#     }
#   }
#   sku = "Standard_B1s"
#   instances = 1
#   admin_username = var.admin_username
#   admin_password = var.admin_password 
#   disable_password_authentication = false 

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "18.04-LTS"
#     version   = "latest"
#   }
# }

