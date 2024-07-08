# Output the public IP address
# output "frontend_lb_public_ip_address" {
#   value       = data.azurerm_public_ip.frontend_lb_pip.ip_address
#   description = "The public IP address of the backend load balancer"
# }

# # Output the public IP address
# output "backend_lb_public_ip_address" {
#   value       = data.azurerm_public_ip.backend_lb_pip.ip_address
#   description = "The public IP address of the backend load balancer"
# }

# output "frontend_port" {
#   value       = data.azurerm_lb.backend_lb.frontend_ip_configuration[0].load_balancing_rules[0].frontend_port
#   description = "The frontend port of the load balancer"
# }

# output "backend_port" {
#   value       = data.azurerm_lb.frontend_lb.frontend_ip_configuration[0].load_balancing_rules[0].frontend_port
#   description = "The frontend port of the load balancer"
# }