# Devuelve la id del ecs cluster
output "ecs_cluster_id" {
  value = aws_ecs_cluster.main.id
}
