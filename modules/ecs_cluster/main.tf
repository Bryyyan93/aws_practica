resource "aws_ecs_cluster" "this" {
  name = var.cluster_name

  setting {
    name = "containerInsights"
    value = var.containerInsights
  }

  tags = var.tags
}

# Crear el servicio ECS en Fargate
resource "aws_ecs_service" "fargate_service" {
  name = var.service_name
  cluster = aws_ecs_cluster.this.id
  launch_type = "EC2"#"FARGATE"
  desired_count = var.desired_count
  task_definition = var.task_definition

  network_configuration {
    subnets = var.subnets
    security_groups = [ var.security_group_id ]
    assign_public_ip = false
  }

  tags = var.tags

}