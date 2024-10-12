output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_a_id" {
  description = "The ID of the first public subnet"
  value       = module.vpc.public_subnet_a_id
}

output "public_subnet_b_id" {
  description = "The ID of the second public subnet"
  value       = module.vpc.public_subnet_b_id
}

output "ecs_cluster_id" {
  description = "The ID of the ECS Cluster"
  value       = module.ecs_cluster.ecs_cluster_id
}

output "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  value       = module.alb.alb_arn
}

output "target_group_arn" {
  description = "The ARN of the Target Group for ALB"
  value       = module.alb.target_group_arn
}

output "asg_id" {
  description = "The ID of the Auto Scaling Group"
  value       = module.autoscaling.asg_id
}

output "ami_id" {
  value = data.aws_ami.latest_amazon_linux.id
}