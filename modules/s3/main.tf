variable "bucket_name" {
  default = "my-terraform-bucket-us-west-2"
}

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
}

output "bucket_id" {
  value = aws_s3_bucket.this.id
}
