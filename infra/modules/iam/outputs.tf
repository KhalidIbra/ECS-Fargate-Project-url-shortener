output "execution_role_arn" {
  value = aws_iam_role.ecs_execution.arn
}

output "task_role_arn" {
  value = aws_iam_role.ecs_task.arn
}

output "codedeploy_role_arn" {
  value = aws_iam_role.codedeploy.arn
}

output "github_actions_role_arn" {
  value = aws_iam_role.github_actions.arn
}
output "dynamodb_table_arn" {
  value = aws_dynamodb_table.tf_lock.arn
}