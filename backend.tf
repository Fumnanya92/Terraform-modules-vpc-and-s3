terraform {
  backend "s3" {
    bucket         = "my-terraform-bucket-us-west-2"
    key            = "terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "your-lock-table-us-west-2"
  }
}
