output "nginx_lb_endpoint" {
  description = "Public endpoint of NGINX Load Balancer"
  value       = module.nginx_service.lb_dns_name
}
