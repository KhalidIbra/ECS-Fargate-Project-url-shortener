terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.11.0"
    }
  }
}


provider "aws" {
  region = "eu-west-1" 
  access_key                  = "test"
  secret_key                  = "test"

endpoints {
    s3       = "http://localhost:4566"
    dynamodb = "http://localhost:4566"
    ecs      = "http://localhost:4566"
    ec2      = "http://localhost:4566"
    elbv2    = "http://localhost:4566"
    iam      = "http://localhost:4566"
    sts      = "http://localhost:4566"
    codedeploy = "http://localhost:4566"
  }
}