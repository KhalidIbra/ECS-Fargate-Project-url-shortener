
azs = ["eu-west-1a", "eu-west-1b"]


container_image = "676206939809.dkr.ecr.eu-west-1.amazonaws.com/my-app:latest"

dynamodb_tablename  = "url-shortener"


github_repo = "https://github.com/KhalidIbra/url-shortener"


name = "url-shortener"


vpc_cidr = "10.0.0.0/16"

private_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnet_cidrs  = ["10.0.101.0/24", "10.0.102.0/24"]



