module "ecs" {
  source = "./modules/ecs"
  service_name   = var.service_name
  container_image = var.container_image
  container_port  = var.container_port
  task_cpu        = var.task_cpu
  task_memory     = var.task_memory
  desired_task_count = var.desired_task_count
  dynamodb_tablename = "ki-url-mappings"
  subnets = module.network.private_subnet_ids
  security_groups = [module.securitygroups.ecs_sg_id]
  alb_target_group_arn = module.alb.blue_tg_arn
  execution_role_arn = module.iam.execution_role_arn
  task_role_arn      = module.iam.task_role_arn
}

module "ecr" {
  source = "./modules/ecr"
  repo_name                = var.repo_name
  image_tag_mutability     = var.image_tag_mutability
  scan_on_push             = var.scan_on_push
  keep_last_images =         var.keep_last_images
  untagged_expiration_days = var.untagged_expiration_days
}

module "alb" {
  source = "./modules/alb"
  vpc_id = var.vpc_id
  private_subnet_mappings = var.private_subnet_mappings
  alb_security_group = [module.securitygroups.alb_sg_id]
  waf_web_acl_arn = var.waf_web_acl_arn
  
  
}

module "network" {
  source = "./modules/network"
  vpc_cidr = var.vpc_cidr
  azs = var.azs
  private_subnet_cidrs =  var.private_subnet_cidrs
  public_subnet_cidrs = var.public_subnet_cidrs
  region = var.region
  endpoint_sg_id = [module.securitygroups.endpoint_sg_id]
}

module "codedeploy" {
  source = "./modules/codedeploy"
  name = var.name
  ecs_service_name = module.ecs.service_name
  ecs_cluster_name = module.ecs.cluster_id
  green_target_group_name = module.alb.green_tg_arn
  listener_arn = [module.alb.listener_arn]
  blue_target_group_name = module.alb.blue_tg_arn
  codedeploy_role_arn = var.codedeploy_role_arn
}

module "iam" {
  source = "./modules/iam"
  github_repo = var.github_repo
  dynamodb_table_arn = var.dynamodb_table_arn
}

module "securitygroups" {
  source = "./modules/securitygroups"
  vpc_id = module.network.vpc_id
}

module "waf" {
  source = "./modules/waf"
  alb_arn = module.alb.alb_arn
}

