variable "resource_group_name" {
  description = "The name of the resource group"
  default     = "terraform-rg"
}

variable "location" {
  description = "The location where resources will be created"
  default     = "East US"
}

variable "vnet_name" {
  description = "The name of the virtual network"
  default     = "terraform-vnet"
}

variable "vnet_address_space" {
  description = "The address space for the virtual network"
  default     = "10.0.0.0/16"
}

variable "subnet_1_cidr" {
  description = "The CIDR block for subnet 1"
  default     = "10.0.1.0/24"
}

variable "subnet_2_cidr" {
  description = "The CIDR block for subnet 2"
  default     = "10.0.2.0/24"
}

variable "vm_size" {
  description = "The size of the virtual machines"
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "The admin username for the virtual machines"
  default     = "adminuser"
}

variable "admin_password" {
  description = "The admin password for the virtual machines"
  default     = "P@ssw0rd1234!"
}

variable "frontend_lb_pip_name" {
  description = "The name of the public IP address"
  type        = string
  default = "frontend-lb-pip"
}

variable "backend_lb_pip_name" {
  description = "The name of the public IP address"
  type        = string
  default = "backend-lb-pip"
}

variable "frontend_lb_name" {
  description = "The name of the public IP address"
  type        = string
  default = "frontend-lb"
}

variable "backend_lb_name" {
  description = "The name of the public IP address"
  type        = string
  default = "backend-lb"
}



