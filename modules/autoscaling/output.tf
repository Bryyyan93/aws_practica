# Devuelve el ID del Auto Scaling Group (ASG) que gestiona las instancias ECS
output "asg_id" {
  value = aws_autoscaling_group.ecs_asg.id
}
