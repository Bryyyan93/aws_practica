resource "aws_security_group" "this" {
  name        = var.sg_name
  description = "Allow HTTP traffic to ALB"
  vpc_id = var.vpc_id

 # Permitir tráfico HTTP (puerto 80) desde cualquier origen
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Permite tráfico HTTP desde cualquier IP
  }
/*
    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.local_cidr]  # Permitir tráfico SSH solo desde la red local
  }
*/
  # Permitir tráfico de salida (egress) a cualquier destino
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sg_name
  }
}
