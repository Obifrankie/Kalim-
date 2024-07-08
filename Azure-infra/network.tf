# Resource Group
resource "azurerm_resource_group" "main_rg" {
  name     = var.resource_group_name
  location = var.location
}

# Virtual Network
resource "azurerm_virtual_network" "main_vnet" {
  name                = var.vnet_name
  address_space       = [var.vnet_address_space]
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name
}

# Subnet 1
resource "azurerm_subnet" "subnet_1" {
  name                 = "subnet_1"
  resource_group_name  = azurerm_resource_group.main_rg.name
  virtual_network_name = azurerm_virtual_network.main_vnet.name
  address_prefixes     = [var.subnet_1_cidr]
}

# Subnet 2
resource "azurerm_subnet" "subnet_2" {
  name                 = "subnet_2"
  resource_group_name  = azurerm_resource_group.main_rg.name
  virtual_network_name = azurerm_virtual_network.main_vnet.name
  address_prefixes     = [var.subnet_2_cidr]
  
}

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

resource "azurerm_network_security_group" "nsg_frontend" {
  name                = "vmss-nsg"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["22", "80"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "nsg_backend" {
  name                = "vmss-nsg"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["22", "8080"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}