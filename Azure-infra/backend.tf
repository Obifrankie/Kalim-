terraform {
    backend "azurerm" {
    resource_group_name   = "terraform-backend"         # Replace with your resource group name
    storage_account_name  = "kalimbackendt"     # Replace with your Azure Storage account name
    container_name        = "backend"  # Replace with your blob container name
    key                   = "terraform.tfstate"  # Replace with your desired state file name
  }
}
