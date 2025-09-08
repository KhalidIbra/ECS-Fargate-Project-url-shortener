output "alb_arn" {
  value       = aws_alb.ki_alb.arn
}

output "alb_dns_name" {
  value       = aws_alb.ki_alb.dns_name
}

output "listener_arn" {
  value       = aws_lb_listener.http.arn
}

output "blue_tg_arn" {
  value       = aws_lb_target_group.blue.arn
}

output "green_tg_arn" {
  value       = aws_lb_target_group.green.arn
}
