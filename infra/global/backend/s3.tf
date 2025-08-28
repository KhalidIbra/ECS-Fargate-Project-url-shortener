provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "tf_state" {
  bucket = var.bucket_name
  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle {
    prevent_destroy = true
  }
  
  tags = {
        Name = "S3 Remote Terraform State Store"
    }

}


