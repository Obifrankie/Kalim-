
    bucket         = "kalim-terraform-backend"  # Replace with your S3 bucket name
    key            = "terraform.tfstate"            # Replace with your desired state file name
    region         = "eu-west-1"                    # Replace with your desired AWS region
    # dynamodb_table = "terraform-lock"               # Optional: DynamoDB table for state locking
