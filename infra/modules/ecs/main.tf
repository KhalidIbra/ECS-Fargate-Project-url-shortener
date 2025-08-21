resource "aws_ecs_task_definition" "ki_td" {
    family    = var.service_name-var.region
    cpu       = var.task_cpu
    memory    = var.task_memory
    network_mode = "awsvpc"
    requires_compatibilities =  ["FARGATE"]
    execution_role_arn = var.execution_role_arn
    task_role_arn = var.task_role_arn




   container_definitions = jsonencode([{
    name     = var.service_name
    image    = var.container_image

    cpu      = var.task_cpu
    memory   = var.task_memory

    essential = true 

    portMappings = [{
       containerPort = var.container_port
       hostPort     =  var.container_port
       protocol     = "tcp" 
    }]

    environment = [
        { name = "TABLE_NAME", value = var.dynamodb_tablename}
    ]
    log_configuration = {
        logDriver = "awslogs"
        options = {
            awslogs-group = aws_cloudwatch_log_group.ki_ecs_log_group
            awslogs-region = eu-west-2
            awslogs-stream-prefix ="ecs"
        }
    }
   }])
}



resource "aws_ecs_service" "ki_service" {
  name            = var.service_name
  cluster         = var.cluster_name
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_task_count
  launch_type = "FARGATE"

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  network_configuration {
    assign_public_ip = false 
    subnets          = [for o in var.subnet_mappings : o.id]
    security_groups  = var.security_groups
  }

  load_balancer {
    container_name = var.service_name
    container_port = var.container_port
    target_group_arn = var.alb_target_group_arn
  }
}