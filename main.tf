module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"  # Customize as needed
}

#module "s3_bucket" {
#  source = "./modules/s3"
#  bucket_name = "my-terraform-bucket-us-west-2"  # Customize as needed
#}
