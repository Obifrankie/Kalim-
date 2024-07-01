provider "aws" {
  region  = "eu-west-1"
  profile = "default"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# # Include network resources
# module "network" {
#   source = ".//network"
# }

# # Include compute resources
# module "compute" {
#   source = ".//compute"
# }



