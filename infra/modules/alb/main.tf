resource "aws_alb" "ki_alb" {  
  name            = "${var.service_name}-alb"  
  subnets         = var.private_subnet_mappings
  security_groups = var.alb_security_group
  internal        = false
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
  load_balancer_arn = aws_alb.ki_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
     target_group_arn = aws_lb_target_group.blue.name  
  }

  lifecycle {
    ignore_changes = [default_action] 
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_alb.ki_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.acm_certificate_arn

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.blue.name
  }
}



resource "aws_wafv2_web_acl_association" "this" {
  resource_arn = aws_alb.ki_alb.arn
  web_acl_arn  = var.waf_web_acl_arn
}




