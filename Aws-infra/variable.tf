variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_blocks" {
  description = "List of CIDR blocks for subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b"]
}

variable "nat_gateway_name" {
  description = "Name for the NAT gateway"
  type        = string
  default     = "main_nat_gw"
}

variable "internet_gateway_name" {
  description = "Name for the internet gateway"
  type        = string
  default     = "main_igw"
}

variable "public_route_table_name" {
  description = "Name for the public route table"
  type        = string
  default     = "public_rt"
}

variable "private_route_table_name" {
  description = "Name for the private route table"
  type        = string
  default     = "private_rt"
}

variable "frontend_security_group_name" {
  description = "Name for the frontend security group"
  type        = string
  default     = "frontend_sg"
}

variable "backend_security_group_name" {
  description = "Name for the backend security group"
  type        = string
  default     = "backend_sg"
}

variable "image_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
  default     = "ami-0776c814353b4814d"
}

variable "frontend_lc_name" {
  description = "Name for the frontend launch configuration"
  type        = string
  default     = "frontend-lc"
}

variable "backend_lc_name" {
  description = "Name for the backend launch configuration"
  type        = string
  default     = "backend-lc"
}

variable "frontend_asg_name" {
  description = "Name for the frontend autoscaling group"
  type        = string
  default     = "frontend_asg"
}

variable "backend_asg_name" {
  description = "Name for the backend autoscaling group"
  type        = string
  default     = "backend_asg"
}

variable "frontend_lb_name" {
  description = "Name for the frontend load balancer"
  type        = string
  default     = "frontend-lb"
}

variable "backend_lb_name" {
  description = "Name for the backend load balancer"
  type        = string
  default     = "backend-lb"
}

variable "frontend_tg_name" {
  description = "Name for the frontend target group"
  type        = string
  default     = "frontend-tg"
}

variable "backend_tg_name" {
  description = "Name for the backend target group"
  type        = string
  default     = "backend-tg"
}

