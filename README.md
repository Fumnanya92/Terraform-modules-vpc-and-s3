# Mini Project: Terraform Modules - VPC and S3 Bucket with Backend Storage

## Purpose
The purpose of this project is to create a modularized Terraform configuration that builds an Amazon Virtual Private Cloud (VPC) and an Amazon S3 bucket. Additionally, Terraform will be configured to use S3 as the backend storage for the Terraform state file.

---

## Project Tasks

### Task 1: VPC Module
1. **Create Project Directory**  
   Open a terminal and create a new directory for your Terraform project:
   ```bash
   mkdir terraform-modules-vpc-s3
   cd terraform-modules-vpc-s3
   ```

2. **Create VPC Module Directory**  
   Inside the project directory, create a subdirectory for the VPC module:
   ```bash
   mkdir -p modules/vpc
   ```

3. **Write VPC Module Configuration**  
   Create the `main.tf` file inside the `modules/vpc` directory to define the VPC module:
   ```bash
   nano modules/vpc/main.tf
   ```
   Add the following content (adjust as necessary):
   ```hcl
   variable "vpc_cidr" {
     default = "10.0.0.0/16"
   }

   resource "aws_vpc" "this" {
     cidr_block = var.vpc_cidr
   }

   output "vpc_id" {
     value = aws_vpc.this.id
   }
   ```

4. **Use the VPC Module in the Main Configuration**  
   In the root project directory, create a `main.tf` file:
   ```bash
   nano main.tf
   ```
   Use the VPC module in this file:
   ```hcl
   provider "aws" {
     region = "us-east-1" # Change this to your desired AWS region
   }

   module "vpc" {
     source = "./modules/vpc"
     vpc_cidr = "10.0.0.0/16"  # Customize as needed
   }
   ```

---

### Task 2: S3 Bucket Module
1. **Create S3 Module Directory**  
   Inside the project directory, create a subdirectory for the S3 module:
   ```bash
   mkdir -p modules/s3
   ```

2. **Write S3 Module Configuration**  
   Create the `main.tf` file inside the `modules/s3` directory:
   ```bash
   nano modules/s3/main.tf
   ```
   Add the following content:
   ```hcl
   variable "bucket_name" {
     default = "my-terraform-bucket"
   }

   resource "aws_s3_bucket" "this" {
     bucket = var.bucket_name
   }

   output "bucket_id" {
     value = aws_s3_bucket.this.id
   }
   ```

3. **Use the S3 Module in the Main Configuration**  
   Modify the `main.tf` file in the root directory to use the S3 module:
   ```bash
   nano main.tf
   ```
   Add the following:
   ```hcl
   module "s3_bucket" {
     source = "./modules/s3"
     bucket_name = "your-custom-bucket-name"  # Customize as needed
   }
   ```

---

### Task 3: Backend Storage Configuration
1. **Configure Backend Storage for Terraform**  
   In the root project directory, create a `backend.tf` file:
   ```bash
   nano backend.tf
   ```
   Add the following content to configure S3 as backend storage:
   ```hcl
   terraform {
     backend "s3" {
       bucket         = "your-terraform-state-bucket"
       key            = "terraform.tfstate"
       region         = "us-east-1"
       encrypt        = true
       dynamodb_table = "your-lock-table"
     }
   }
   ```

2. **Initialize Terraform**  
   Run the following command to initialize your Terraform project:
   ```bash
   terraform init
   ```

3. **Apply Terraform Configuration**  
   Apply the configuration to create the VPC and S3 bucket:
   ```bash
   terraform apply
   ```
   Confirm when prompted to proceed with the infrastructure creation.

---

## Observations & Challenges

1. **Observations:**
   - The modular approach makes it easier to manage and reuse configurations across different projects.
   - Using S3 as the backend storage ensures the Terraform state file is centralized and secured.

2. **Challenges:**
   - Ensure that the S3 bucket used for backend storage exists before running `terraform init`.
   - Be cautious when specifying the `region` and `bucket` in the backend configuration to avoid potential issues with accessing the S3 bucket.
