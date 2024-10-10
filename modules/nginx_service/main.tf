# Definir el task definition de ECS para contenedor NGINX
resource "aws_ecs_task_definition" "nginx" {
  family                = var.task_family
  network_mode          = "awsvpc"
  requires_compatibilities = ["EC2"]  # Cambiado a EC2 en lugar de Fargate
  cpu                   = var.cpu
  memory                = var.memory
  execution_role_arn    = var.execution_role_arn
  task_role_arn         = var.task_role_arn

  container_definitions = jsonencode([
    {
      name      = "nginx"
      image     = "nginx:latest"
      cpu       = var.container_cpu
      memory    = var.container_memory
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}

# Crear el servicio para gestionar el contenedor
resource "aws_ecs_service" "nginx_service" {
  name            = var.service_name
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.nginx.arn
  desired_count   = var.desired_count
  launch_type     = "EC2"  # Cambiado a EC2

  network_configuration {
    subnets         = var.subnets
    security_groups = [var.security_group_id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.nginx_tg.arn
    container_name   = "nginx"
    container_port   = 80
  }

  tags = var.tags
}

# Crear el balancedor de carga para gestionar el trafico
resource "aws_lb" "nginx_alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_security_group_id]
  subnets            = var.subnets

  tags = var.tags
}

resource "aws_lb_target_group" "nginx_tg" {
  name        = var.target_group_name
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

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

resource "aws_lb_listener" "nginx_listener" {
  load_balancer_arn = aws_lb.nginx_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx_tg.arn
  }
}
