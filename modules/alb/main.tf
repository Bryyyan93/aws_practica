# Recurso para crear un Application Load Balancer (ALB) en AWS.
# Este balanceador de carga se utilizará para distribuir el tráfico HTTP a las instancias ECS.
resource "aws_lb" "ecs_alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.subnets
  # Etiquetas para el ALB, para identificación en AWS.
  tags = {
    Name = var.alb_name
  }
}

# Recurso para crear un Target Group que será utilizado por el ALB.
# Este grupo define el puerto y protocolo de las instancias a las que se enruta el tráfico.
resource "aws_lb_target_group" "ecs_tg" {
  name     = var.target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  # Verifica que las instancias estén saludables.
  health_check {
    path = "/"
    port = "80"
  }
}

# Recurso para crear un Listener para el ALB.
# Este listener escucha el tráfico en el puerto 80 (HTTP) y lo redirige al Target Group.
resource "aws_lb_listener" "ecs_listener" {
  load_balancer_arn = aws_lb.ecs_alb.arn
  port              = 80
  protocol          = "HTTP"

  # Redirige el tráfico al Target Group.
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg.arn
  }
}
