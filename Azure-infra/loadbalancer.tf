# # Public IP for Load Balancer
# resource "azurerm_public_ip" "frontend_lb_pip" {
#   name                = "frontend-lb-pip"
#   location            = azurerm_resource_group.main_rg.location
#   resource_group_name = azurerm_resource_group.main_rg.name
#   allocation_method   = "Static"
#   sku                 = "Standard"
# }

# resource "azurerm_public_ip" "backend_lb_pip" {
#   name                = "backend-lb-pip"
#   location            = azurerm_resource_group.main_rg.location
#   resource_group_name = azurerm_resource_group.main_rg.name
#   allocation_method   = "Static"
#   sku                 = "Standard"
# }

# # Load Balancer for Frontend
# resource "azurerm_lb" "frontend_lb" {
#   name                = "frontend-lb"
#   location            = azurerm_resource_group.main_rg.location
#   resource_group_name = azurerm_resource_group.main_rg.name
#   sku                 = "Standard"

#   frontend_ip_configuration {
#     name                 = "frontend-config"
#     public_ip_address_id = azurerm_public_ip.frontend_lb_pip.id
#   }
# }

# # Load Balancer for Backend
# resource "azurerm_lb" "backend_lb" {
#   name                = "backend-lb"
#   location            = azurerm_resource_group.main_rg.location
#   resource_group_name = azurerm_resource_group.main_rg.name
#   sku                 = "Standard"

#   frontend_ip_configuration {
#     name                 = "backend-config"
#     public_ip_address_id = azurerm_public_ip.backend_lb_pip.id
#   }
# }

# # Backend Address Pool for Load Balancers
# resource "azurerm_lb_backend_address_pool" "frontend_bap" {
#   loadbalancer_id = azurerm_lb.frontend_lb.id
#   name            = "frontend-bap"
# }

# resource "azurerm_lb_backend_address_pool" "backend_bap" {
#   loadbalancer_id = azurerm_lb.backend_lb.id
#   name            = "backend-bap"
# }

# # Health Probes for Load Balancers
# resource "azurerm_lb_probe" "frontend_probe" {
#   loadbalancer_id = azurerm_lb.frontend_lb.id
#   name            = "frontend-probe"
#   protocol        = "Tcp"
#   port            = 80

#   interval_in_seconds = 5
#   number_of_probes    = 2
# }

# resource "azurerm_lb_probe" "backend_probe" {
#   loadbalancer_id = azurerm_lb.backend_lb.id
#   name            = "backend-probe"
#   protocol        = "Tcp"
#   port            = 80

#   interval_in_seconds = 5
#   number_of_probes    = 2
# }

# # Load Balancer Rules
# resource "azurerm_lb_rule" "frontend_lb_rule" {
#   loadbalancer_id            = azurerm_lb.frontend_lb.id
#   name                       = "frontend-lb-rule"
#   protocol                   = "Tcp"
#   frontend_port              = 80
#   backend_port               = 80
#   frontend_ip_configuration_name = "frontend-config"
#   backend_address_pool_ids = [azurerm_lb_backend_address_pool.frontend_bap.id]
#   probe_id                   = azurerm_lb_probe.frontend_probe.id
# }

# resource "azurerm_lb_rule" "backend_lb_rule" {
#   loadbalancer_id            = azurerm_lb.backend_lb.id
#   name                       = "backend-lb-rule"
#   protocol                   = "Tcp"
#   frontend_port              = 80
#   backend_port               = 80
#   frontend_ip_configuration_name = "backend-config"
#   backend_address_pool_ids = [azurerm_lb_backend_address_pool.backend_bap.id]
#   probe_id                   = azurerm_lb_probe.backend_probe.id
# }

# # NAT Pool for Frontend Load Balancer
# resource "azurerm_lb_nat_pool" "frontend_nat_pool" {
#   name                     = "frontend-nat-pool"
#   resource_group_name      = azurerm_resource_group.main_rg.name
#   loadbalancer_id          = azurerm_lb.frontend_lb.id
#   protocol                 = "Tcp"
#   frontend_port_start      = 50000
#   frontend_port_end        = 50119
#   backend_port             = 22
#   frontend_ip_configuration_name = "frontend-config"
# }

# # NAT Pool for Backend Load Balancer
# resource "azurerm_lb_nat_pool" "backend_nat_pool" {
#   name                     = "backend-nat-pool"
#   resource_group_name      = azurerm_resource_group.main_rg.name
#   loadbalancer_id          = azurerm_lb.backend_lb.id
#   protocol                 = "Tcp"
#   frontend_port_start      = 50200
#   frontend_port_end        = 50319
#   backend_port             = 22
#   frontend_ip_configuration_name = "backend-config"
# }



# Public IP for Load Balancer
resource "azurerm_public_ip" "frontend_lb_pip" {
  name                = "frontend-lb-pip"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_public_ip" "backend_lb_pip" {
  name                = "backend-lb-pip"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Load Balancer for Frontend
resource "azurerm_lb" "frontend_lb" {
  name                = "frontend-lb"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "frontend-config"
    public_ip_address_id = azurerm_public_ip.frontend_lb_pip.id
  }
}

# Load Balancer for Backend
resource "azurerm_lb" "backend_lb" {
  name                = "backend-lb"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "backend-config"
    public_ip_address_id = azurerm_public_ip.backend_lb_pip.id
  }
}

# Backend Address Pool for Load Balancers
resource "azurerm_lb_backend_address_pool" "frontend_bap" {
  loadbalancer_id = azurerm_lb.frontend_lb.id
  name            = "frontend-bap"
}

resource "azurerm_lb_backend_address_pool" "backend_bap" {
  loadbalancer_id = azurerm_lb.backend_lb.id
  name            = "backend-bap"
}

# Health Probes for Load Balancers
resource "azurerm_lb_probe" "frontend_probe" {
  loadbalancer_id = azurerm_lb.frontend_lb.id
  name            = "frontend-probe"
  protocol        = "Tcp"
  port            = 80

  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_lb_probe" "backend_probe" {
  loadbalancer_id = azurerm_lb.backend_lb.id
  name            = "backend-probe"
  protocol        = "Tcp"
  port            = 80

  interval_in_seconds = 5
  number_of_probes    = 2
}

# Load Balancer Rules
resource "azurerm_lb_rule" "frontend_lb_rule" {
  loadbalancer_id            = azurerm_lb.frontend_lb.id
  name                       = "frontend-lb-rule"
  protocol                   = "Tcp"
  frontend_port              = 80
  backend_port               = 80
  frontend_ip_configuration_name = "frontend-config"
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.frontend_bap.id]
  probe_id                   = azurerm_lb_probe.frontend_probe.id
}

resource "azurerm_lb_rule" "backend_lb_rule" {
  loadbalancer_id            = azurerm_lb.backend_lb.id
  name                       = "backend-lb-rule"
  protocol                   = "Tcp"
  frontend_port              = 80
  backend_port               = 80
  frontend_ip_configuration_name = "backend-config"
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.backend_bap.id]
  probe_id                   = azurerm_lb_probe.backend_probe.id
}

# NAT Pool for Frontend Load Balancer
resource "azurerm_lb_nat_pool" "frontend_nat_pool" {
  name                     = "frontend-nat-pool"
  resource_group_name      = azurerm_resource_group.main_rg.name
  loadbalancer_id          = azurerm_lb.frontend_lb.id
  protocol                 = "Tcp"
  frontend_port_start      = 50000
  frontend_port_end        = 50119
  backend_port             = 22
  frontend_ip_configuration_name = "frontend-config"
}

# NAT Pool for Backend Load Balancer
resource "azurerm_lb_nat_pool" "backend_nat_pool" {
  name                     = "backend-nat-pool"
  resource_group_name      = azurerm_resource_group.main_rg.name
  loadbalancer_id          = azurerm_lb.backend_lb.id
  protocol                 = "Tcp"
  frontend_port_start      = 50200
  frontend_port_end        = 50319
  backend_port             = 22
  frontend_ip_configuration_name = "backend-config"
}