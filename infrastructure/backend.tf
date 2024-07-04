# terraform {
#   backend "s3" {
#     bucket         = "kalim-terraform-backend"  # Replace with your S3 bucket name
#     key            = "terraform.tfstate"            # Replace with your desired state file name
#     region         = "eu-west-1"                    # Replace with your desired AWS region
#     profile        = "default"                      # Replace with your AWS profile if not using default
#     # dynamodb_table = "terraform-lock"               # Optional: DynamoDB table for state locking
#   }
# }