terraform {
  backend "s3" {
    bucket         = "ki-terraform-state"
    key            = "ecs-fargate/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "ki-terraform-locks"
    encrypt        = true
  }
}
