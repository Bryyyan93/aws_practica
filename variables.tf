###################### Definición de variables #########################
# Estas variables te permiten parametrizar el despliegue de tu infraestructura
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

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "kc-vpc-pf-bryan"
}

variable "gateway_name" {
  description = "Name of the gateway"
  default     = "kc-gw-pf-bryan"
}

variable "public_subnet_a_name" {
  description = "Name of the subnet a"
  default     = "kc-public-subnet-a-bryan"
}

variable "public_subnet_b_name" {
  description = "Name of the subnet b"
  default     = "kc-public-subnet-b-bryan"
}

variable "route_table_name" {
  description = "Name of the route table"
  default     = "kc-route-table-bryan"
}

# ECS Cluster variables
variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "kc-ecs-cluster-pf-bryan"
}

variable "ecs_instance_name" {
  description = "ECS instance name for the instances"
  type        = string
  default     = "kc-ecs-instance-bryan"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "desired_capacity" {
  description = "Desired number of EC2 instances"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum number of EC2 instances"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of EC2 instances"
  type        = number
  default     = 3
}

# Utilización objetivo de la CPU
variable "cpu_target" {
  description = "Maximun CPU usage"
  default     = 70
}

# Cooldown antes de reducir
variable "cd_bef_red" {
  description = "Cooldown before the reducition of the instances"
  default     = 300
}

# Cooldown antes de escalar hacia arriba
variable "cd_bef_add" {
  description = "Cooldown before adding instances"
  default     = 300
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
