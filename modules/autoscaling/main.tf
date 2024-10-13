data "aws_ssm_parameter" "ecs_node_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

# Launch Template para las instancias EC2
resource "aws_launch_template" "ecs_launch_template" {
  name_prefix   = "kc-ecs-launch-template-pf-bryan"
  image_id        = data.aws_ssm_parameter.ecs_node_ami.value #var.ami_id
  instance_type   = var.instance_type

  # Acceso ssh
  key_name = "kc-kp-bryan"
    
  #iam_instance_profile = var.instance_profile_name
  iam_instance_profile {
    name = var.instance_profile_name
  }

  #security_groups = [var.security_group_id]
  network_interfaces {
    security_groups = [var.security_group_id]
    associate_public_ip_address = true
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              echo ECS_CLUSTER=${var.ecs_cluster_name} >> /etc/ecs/ecs.config
            EOF
          )
}

# Auto Scaling Group que usa el Launch Template
resource "aws_autoscaling_group" "ecs_asg" {
  name_prefix = "kc-ag-pf-bryan"
  #launch_configuration = aws_launch_configuration.ecs_launch_config.id
  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.desired_capacity
  vpc_zone_identifier  = var.subnets

  launch_template {
    id      = aws_launch_template.ecs_launch_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = var.ecs_instance_name
    propagate_at_launch = true
  }
}

# Crear el capacity provider
resource "aws_ecs_capacity_provider" "ecs_capacity_provider" {
  name = "kc-ecs-capacity-provider-bryan"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.ecs_asg.arn
    managed_termination_protection = "DISABLED"

    managed_scaling {
      maximum_scaling_step_size = 2
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 100
    }
  }
}
# Asociar el Capacity Provider al ECS Cluster
resource "aws_ecs_cluster_capacity_providers" "ecs_cluster_capacity_providers" {
  cluster_name       = var.ecs_cluster_name
  capacity_providers = [aws_ecs_capacity_provider.ecs_capacity_provider.name]

  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.ecs_capacity_provider.name
    weight            = 1
  }
}

# Task Definition para NGINX
resource "aws_ecs_task_definition" "nginx_task" {
  family                   = "nginx-task"
  network_mode             = "bridge" # Cambia a bridge para compatibilidad con target_type instance
  requires_compatibilities = ["EC2"]
  execution_role_arn       = var.ecs_task_execution_role_arn
  container_definitions = jsonencode([{
    name      = "nginx"
    image     = "nginx:latest"
    essential = true
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]
    memory   = 512
    cpu      = 256
  }])
}

# servicio ECS orquestará el despliegue de NGINX en las instancias EC2
resource "aws_ecs_service" "nginx_service" {
  name            = "nginx-service"
  cluster         = var.ecs_cluster_name
  task_definition = aws_ecs_task_definition.nginx_task.arn
  desired_count   = 1
  launch_type     = "EC2"
/* #Solo sirve si la configuracion de red en awsvpc
  network_configuration {
    subnets         = var.subnets
    security_groups = [var.security_group_id]
    assign_public_ip = true
  }
*/
  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "nginx"
    container_port   = 80
  }

  depends_on = [
    var.lb_listener_arn  # Usar la variable lb_listener_arn
  ]
}

# Definir el escalado automático para el servicio ECS
resource "aws_appautoscaling_target" "ecs_target" {
  service_namespace  = "ecs" # Tiene que ser el nombre del recurso, en este caso ecs
  scalable_dimension = "ecs:service:DesiredCount"
  resource_id        = "service/${var.ecs_cluster_name}/${aws_ecs_service.nginx_service.name}"
  min_capacity       = var.min_size
  max_capacity       = var.max_size
}

resource "aws_appautoscaling_policy" "ecs_target_cpu" {
  name               = "application-scaling-policy-cpu"
  policy_type        = "TargetTrackingScaling"
  service_namespace  = "ecs"  # Directamente asignamos "ecs"
  resource_id        = "service/${var.ecs_cluster_name}/${aws_ecs_service.nginx_service.name}"  # Usamos el resource_id con el nombre del clúster y el servicio
  scalable_dimension = "ecs:service:DesiredCount"  # Asignamos directamente la dimensión escalable

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value       = var.cpu_target  # Utilización objetivo de la CPU
    scale_in_cooldown  = var.cd_bef_red  # Cooldown antes de reducir
    scale_out_cooldown = var.cd_bef_add  # Cooldown antes de escalar hacia arriba
  }

  # Agregar dependencia explícita para asegurar el orden correcto
  depends_on = [aws_appautoscaling_target.ecs_target]
}
