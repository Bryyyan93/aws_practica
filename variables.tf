# General AWS region
variable "region" {
  description = "AWS region to deploy the infrastructure"
  type        = string
  default     = "eu-west-1"
}

# VPC module variables
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_a_cidr" {
  description = "CIDR block for the first public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_b_cidr" {
  description = "CIDR block for the second public subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "availability_zone_a" {
  description = "The availability zone for the first subnet"
  type        = string
  default     = "eu-west-1a"
}

variable "availability_zone_b" {
  description = "The availability zone for the second subnet"
  type        = string
  default     = "eu-west-1b"
}

# ECS Cluster variables
variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "kc-ecs-cluster-pf-bryan"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "desired_capacity" {
  description = "Desired number of EC2 instances"
  type        = number
  default     = 1
}

variable "min_size" {
  description = "Minimum number of EC2 instances"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of EC2 instances"
  type        = number
  default     = 3
}

# ALB module variables
variable "alb_name" {
  description = "The name of the Application Load Balancer"
  type        = string
  default     = "ecs-alb-bryan"
}

variable "target_group_name" {
  description = "The name of the target group for ALB"
  type        = string
  default     = "ecs-target-group-bryan"
}

# Valores por defecto
/*
# Security Group for EC2 and ALB
variable "security_group_id" {
  description = "The ID of the security group for the instances and ALB"
  type        = string
}

# Instance Profile Name for EC2
variable "instance_profile_name" {
  description = "The name of the IAM instance profile for the EC2 instances"
  type        = string
}

# Auto Scaling Group variables

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
  #default     = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 ECS Optimized AMI
}
*/
