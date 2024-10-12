# Launch Template para las instancias EC2
resource "aws_launch_template" "ecs_launch_template" {
  name_prefix   = "kc-ecs-launch-template-pf-bryan"
  image_id        = var.ami_id
  instance_type   = var.instance_type
    
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

