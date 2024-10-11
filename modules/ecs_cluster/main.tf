resource "aws_ecs_cluster" "this" {
  name = var.cluster_name

  setting {
    name = "containerInsights"
    value = var.containerInsights
  }

  tags = var.tags
}

# Crear el servicio ECS
resource "aws_ecs_service" "service" {
  name = var.service_name
  cluster = aws_ecs_cluster.this.id
  launch_type = "EC2"
  desired_count = var.desired_count
  task_definition = var.task_definition

  network_configuration {
    subnets = var.subnets
    security_groups = [ var.security_group_id ]
    assign_public_ip = false
  }

  tags = var.tags

}

# Agregar instancias EC2
resource "aws_launch_template" "ecs_launch_template" {
  name = "ecs-launch-template"

  image_id      = data.aws_ami.ecs_optimized.id
  instance_type = "t2.micro"  # Puedes ajustar el tamaño según lo necesites.

  user_data = base64encode(<<EOF
#!/bin/bash
echo ECS_CLUSTER=${var.cluster_name} >> /etc/ecs/ecs.config
EOF
  )

  #key_name = var.key_name  # Si deseas conectarte vía SSH
}

# Crear un target group especificaco para crear las instancias EC2
resource "aws_lb_target_group" "ecs_instance_tg" {
  name        = "ecs-instance-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"  # Este TG es para las instancias EC2 del ASG

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    protocol            = "HTTP"
  }

  tags = var.tags
}

resource "aws_autoscaling_group" "ecs_asg" {
  launch_template {
    id      = aws_launch_template.ecs_launch_template.id
    version = "$Latest"
  }

  vpc_zone_identifier = var.subnets #module.vpc.public_subnet_ids  # Asegúrate de lanzar las instancias en subnets públicas
  desired_capacity    = 1  # El número de instancias que deseas
  max_size            = 3
  min_size            = 1

  target_group_arns = [aws_lb_target_group.ecs_instance_tg.arn]

  health_check_type         = "EC2"
  health_check_grace_period = 300

    # Agregar políticas de escalado opcionalmente
  tag {
    key                 = "Name"
    value               = "kc-ecs-instance-pf-bryan"
    propagate_at_launch = true
  }  

}

data "aws_ami" "ecs_optimized" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }

  #owners = ["591542846629"]  # Amazon ECS AMI owner ID
}

# Escalar por cpu
resource "aws_autoscaling_policy" "cpu_policy" {
  name                   = "scale-up-policy"
  scaling_adjustment      = 1
  adjustment_type         = "ChangeInCapacity"
  cooldown                = 300
  autoscaling_group_name  = aws_autoscaling_group.ecs_asg.name

  # Escalar cuando el uso de CPU exceda el 70%
  policy_type             = "SimpleScaling"
  metric_aggregation_type = "Average"
}
/*
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name                = "high-cpu"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "70"

  alarm_actions             = [aws_autoscaling_policy.cpu_policy.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ecs_asg.name
  }
}
*/
