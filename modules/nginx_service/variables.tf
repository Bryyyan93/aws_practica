variable "cluster_id" {
  description = "ECS Cluster ID"
  type = string
  default = "kc-ecs-cluster-bryan"
}

variable "subnets" {
  description = "List of public subnets"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "ecs_sg_id" {
  description = "Security Group ID for ECS"
  type        = string
}
