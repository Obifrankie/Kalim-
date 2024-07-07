# resource "azurerm_linux_virtual_machine_scale_set" "frontend_vmss" {
#   name                = "frontend-vmss"
#   resource_group_name = azurerm_resource_group.main_rg.name
#   location            = azurerm_resource_group.main_rg.location
#   sku                 = "Standard_F2"
#   instances           = 1
#   admin_username                  = var.admin_username
#   # admin_password                  = var.admin_password
#   # disable_password_authentication = false
#   # user_data = base64decode(templatefile("userdata.tftpl"))

#   admin_ssh_key {
#     username   = "adminuser"
#     public_key = file("vm.pub")
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts"
#     version   = "latest"
#   }

#   os_disk {
#     storage_account_type = "Standard_LRS"
#     caching              = "ReadWrite"
#   }

#   network_interface {
#     name    = "backend-nic"
#     primary = true

#     ip_configuration {
#       name      = "internal"
#       primary   = true
#       subnet_id = azurerm_subnet.subnet_2.id
#       load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.frontend_bap.id]
#       load_balancer_inbound_nat_rules_ids = [
#         azurerm_lb_nat_pool.frontend_nat_pool.id
#       ]
#     }
#   }
# }

# resource "azurerm_linux_virtual_machine_scale_set" "backend_vmss" {
#   name                = "backend-vmss"
#   resource_group_name = azurerm_resource_group.main_rg.name
#   location            = azurerm_resource_group.main_rg.location
#   sku                 = "Standard_F2"
#   instances           = 1
#   admin_username                  = var.admin_username
#   # admin_password                  = var.admin_password
#   # disable_password_authentication = false
#   # user_data = base64decode(templatefile("userdata.tftpl"))

#   admin_ssh_key {
#     username   = "adminuser"
#     public_key = file("vm.pub")
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts"
#     version   = "latest"
#   }

#   os_disk {
#     storage_account_type = "Standard_LRS"
#     caching              = "ReadWrite"
#   }

#   network_interface {
#     name    = "backend-nic"
#     primary = true

#     ip_configuration {
#       name      = "internal"
#       primary   = true
#       subnet_id = azurerm_subnet.subnet_2.id
#       load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.backend_bap.id]
#       load_balancer_inbound_nat_rules_ids = [
#         azurerm_lb_nat_pool.backend_nat_pool.id
#       ]
#     }
#   }
# }




resource "azurerm_linux_virtual_machine_scale_set" "frontend_vmss" {
  name                = "frontend-vmss"
  resource_group_name = azurerm_resource_group.main_rg.name
  location            = azurerm_resource_group.main_rg.location
  sku                 = "Standard_F2"
  instances           = 1
  admin_username      = var.admin_username
  user_data = base64encode(file("userdata.tftpl"))

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("vm.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "frontend-nic"
    primary = true
    network_security_group_id = azurerm_network_security_group.nsg.id
    

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.subnet_2.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.frontend_bap.id]
      load_balancer_inbound_nat_rules_ids = [azurerm_lb_nat_pool.frontend_nat_pool.id]
    }
  }
}

resource "azurerm_linux_virtual_machine_scale_set" "backend_vmss" {
  name                = "backend-vmss"
  resource_group_name = azurerm_resource_group.main_rg.name
  location            = azurerm_resource_group.main_rg.location
  sku                 = "Standard_F2"
  instances           = 1
  admin_username      = var.admin_username
  user_data = base64encode(file("userdata.tftpl"))

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("vm.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "backend-nic"
    primary = true
    network_security_group_id = azurerm_network_security_group.nsg.id

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.subnet_2.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.backend_bap.id]
      load_balancer_inbound_nat_rules_ids = [azurerm_lb_nat_pool.backend_nat_pool.id]
    }
  }
}