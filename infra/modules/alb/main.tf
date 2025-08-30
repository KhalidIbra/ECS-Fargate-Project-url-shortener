resource "aws_alb" "ki_alb" {  
  name            = "${var.service_name}-alb"  
  subnets         = [for o in var.private_subnet_mappings : o.id]
  security_groups = [aws_security_group.alb_security_group.id]
  internal        = true
  load_balancer_type = "application"
}

resource "aws_lb_target_group" "blue" {
  name        = "${var.service_name}-blue-tg"
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/healthz"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }
}

resource "aws_lb_target_group" "green" {
  name        = "${var.service_name}-green-tg"
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/healthz"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }
}


resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
     target_group_arn = aws_lb_target_group.blue.arn   
  }

  lifecycle {
    ignore_changes = [default_action] #Prevents Terraform from rewriting changes made by CodeDeploy
  }
}

resource "aws_wafv2_web_acl_association" "this" {
  resource_arn = aws_lb.this.arn
  web_acl_arn  = var.waf_web_acl_arn
}




