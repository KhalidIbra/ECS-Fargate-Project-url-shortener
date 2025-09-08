
azs = ["us-east-1a", "us-east-1b"]


codedeploy_role_arn = "arn:aws:iam::000000000000:role/CodeDeployRole"


container_image = "000000000000.dkr.ecr.us-east-1.amazonaws.com/my-app:latest"


dynamodb_table_arn  = "arn:aws:dynamodb:us-east-1:000000000000:table/url-shortener"
dynamodb_tablename  = "url-shortener"


github_repo = "my-org/my-repo"


name = "url-shortener"


vpc_id = "vpc-123456"
vpc_cidr = "10.0.0.0/16"

private_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnet_cidrs  = ["10.0.3.0/24", "10.0.4.0/24"]


private_subnet_mappings = {
  subnet1 = { id = "subnet-11111111" }
  subnet2 = { id = "subnet-22222222" }
}



waf_web_acl_arn = "arn:aws:wafv2:us-east-1:000000000000:regional/webacl/test-waf/12345678-1234-1234-1234-123456789012"
