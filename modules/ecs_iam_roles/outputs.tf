output "ecs_task_execution_role_arn" {
  description = "ARN del rol de ejecución de tareas ECS"
  value       = aws_iam_role.ecsTaskExecutionRole.arn
}

output "ecs_task_role_arn" {
  description = "ARN del rol de tarea de ECS"
  value       = aws_iam_role.ecsTaskRole.arn
}
