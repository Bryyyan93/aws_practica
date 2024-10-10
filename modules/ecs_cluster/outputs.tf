output "ecs_cluster_id" {
  description = "ID del ECS Cluster"
  value       = aws_ecs_cluster.this.id
}

output "ecs_service_arn" {
  description = "ARN del ECS Service"
  value       = aws_ecs_service.fargate_service.id
}
