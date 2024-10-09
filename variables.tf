variable "cluster_id" {
  description = "ECS Cluster ID"
}

variable "subnets" {
  description = "List of public subnets"
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "ecs_sg_id" {
  description = "Security Group ID for ECS"
}
