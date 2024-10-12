# Devuelve el ARN del Application Load Balancer (ALB)
output "alb_arn" {
  value = aws_lb.ecs_alb.arn
}

# Devuelve el ARN del Target Group asociado al ALB
output "target_group_arn" {
  value = aws_lb_target_group.ecs_tg.arn
}

# Devuelve el ARN del Listener asociado al ALB
output "listener_arn" {
  value = aws_lb_listener.ecs_listener.arn
}

# Devuelve el DNS Name del Application Load Balancer (ALB)
output "alb_dns" {
  description = "DNS Name of the Application Load Balancer"
  value       = aws_lb.ecs_alb.dns_name
}

