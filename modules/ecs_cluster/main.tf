# Definir el recurso ecs cluster vacio
resource "aws_ecs_cluster" "main" {
  name = var.cluster_name
}
