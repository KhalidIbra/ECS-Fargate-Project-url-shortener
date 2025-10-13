resource "aws_ecs_task_definition" "ki_td" {
    family    = var.service_name
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



     logConfiguration = {
        logDriver = "awslogs"
        options = {
            "awslogs-group"         = "/ecs/${var.service_name}"
            "awslogs-region"        = "var.region"
            "awslogs-stream-prefix" = "ecs"
        }
    }
    }]

    environment = [
        { name = "TABLE_NAME", value = var.dynamodb_tablename}
    ]

   
   }])
}

resource "aws_ecs_cluster" "urlapp" {
  name = "url-shortener"
}

resource "aws_ecs_service" "ki_service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.urlapp.id
  task_definition = aws_ecs_task_definition.ki_td.arn
  desired_count   = var.desired_task_count
  launch_type = "FARGATE"

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  network_configuration {
    assign_public_ip = false 
    subnets          = var.subnets
    security_groups  = var.security_groups
  }

  load_balancer {
    container_name = var.service_name
    container_port = var.container_port
    target_group_arn = var.alb_target_group_arn
  }

  lifecycle {
    ignore_changes = [
      task_definition
    ]
  }
}

resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/ecs/${var.service_name}"
  retention_in_days = 14
}

resource "aws_dynamodb_table" "url_storage" {
  name         = var.dynamodb_tablename
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "UserId"
  attribute {
    name = "UserId"
    type = "S"
  }
}