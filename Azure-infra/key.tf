# resource "tls_private_key" "ssh_key" {
#   algorithm = "RSA"
#   rsa_bits  = 2048
# }

# # resource "azurerm_ssh_public_key" "generated_ssh_key" {
# #   name                = "generated-ssh-key"
# #   resource_group_name = "myResourceGroup"  # Replace with your resource group name
# #   location            = "East US"          # Replace with your location
# # }

# resource "azurerm_ssh_public_key" "generated_ssh_key_public_key" {
#   name                = "generated-ssh-key"
#   resource_group_name = "azurerm_resource_group.main_rg.name"  
#   location            = "azurerm_resource_group.main_rg.location"  

#   public_key = tls_private_key.ssh_key.public_key_openssh
# }

# resource "local_file" "private_key" {
#   content  = tls_private_key.ssh_key.private_key_pem
#   filename = "${path.module}/generated-key.pem"
# }