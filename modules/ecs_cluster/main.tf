resource "aws_ecs_cluster" "nginx_ecs_cluster" {
  name = "nginx-cluster"
}

output "cluster_id" {
  value = aws_ecs_cluster.nginx_ecs_cluster.id
}
