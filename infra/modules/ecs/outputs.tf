output "cluster_id" {
  description = "ID of the ECS cluster"
  value       = aws_ecs_cluster.urlapp.id
}

output "cluster_name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.urlapp.name
}

output "service_name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.ki_service.name
}

output "service_id" {
  description = "ARN of the ECS service"
  value       = aws_ecs_service.ki_service.id
}

output "task_definition_arn" {
  description = "ARN of the task definition"
  value       = aws_ecs_task_definition.ki_td.arn
}
