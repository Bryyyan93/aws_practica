resource "aws_security_group" "ecs_sg" {
  vpc_id = var.vpc_id # Usar la variable vpc_id pasada desde el main.tf

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Permitir tráfico HTTP desde cualquier IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Todo tráfico de salida permitido
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["79.117.8.215/32"]  # Reemplaza con tu IP local, o usa "0.0.0.0/0" para permitir desde cualquier IP
  }

  tags = {
    Name = "ecs-security-group"
  }
}
