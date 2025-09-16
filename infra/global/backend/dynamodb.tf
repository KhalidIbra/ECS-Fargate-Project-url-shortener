resource "aws_dynamodb_table" "tf_lock" {
  name         = var.lock_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"



  point_in_time_recovery {
    enabled = true
  }

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
        Name = "Terraform State Lock Table"
    }
}