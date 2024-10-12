output "alb_arn" {
  value = aws_lb.ecs_alb.arn
}

output "target_group_arn" {
  value = aws_lb_target_group.ecs_tg.arn
}

output "listener_arn" {
  value = aws_lb_listener.ecs_listener.arn
}

