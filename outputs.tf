################### Definición de Output ######################
###############################################################
# Estas instancias pueden ser usadas por otros modulos
# Devuelve el ID de la VPC que se creó a través del módulo "vpc".
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

# Devuelve el ID de la primera subnet pública (A) creada a través del módulo "vpc".
output "public_subnet_a_id" {
  description = "The ID of the first public subnet"
  value       = module.vpc.public_subnet_a_id
}

# Devuelve el ID de la segunda subnet pública (B) creada a través del módulo "vpc".
output "public_subnet_b_id" {
  description = "The ID of the second public subnet"
  value       = module.vpc.public_subnet_b_id
}

# Devuelve el ID del ECS Cluster creado a través del módulo "ecs_cluster".
output "ecs_cluster_id" {
  description = "The ID of the ECS Cluster"
  value       = module.ecs_cluster.ecs_cluster_id
}

# Devuelve el ARN del Application Load Balancer (ALB) creado a través del módulo "alb".
output "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  value       = module.alb.alb_arn
}

# Devuelve el DNS Name del Application Load Balancer (ALB)
output "alb_dns" {
  description = "DNS Name of the Application Load Balancer"
  value       = module.alb.alb_dns #aws_lb.ecs_alb.dns_name
}

# Devuelve el ARN del Target Group asociado al ALB, que es donde las solicitudes se enrutan.
output "target_group_arn" {
  description = "The ARN of the Target Group for ALB"
  value       = module.alb.target_group_arn
}

# Devuelve el ID del Auto Scaling Group (ASG) creado a través del módulo "autoscaling".
output "asg_id" {
  description = "The ID of the Auto Scaling Group"
  value       = module.autoscaling.asg_id
}

# Devuelve el ID de la AMI (Amazon Machine Image) más reciente de Amazon Linux.
output "ami_id" {
  value = data.aws_ami.latest_amazon_linux.id
}