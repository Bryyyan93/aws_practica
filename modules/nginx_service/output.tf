output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.nginx_alb.dns_name
}

output "target_group_arn" {
  description = "ARN del Target Group de NGINX"
  value       = aws_lb_target_group.nginx_tg.arn
}
