variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EC2"
  type        = string
}

variable "security_group_id" {
  description = "ID of the security group for the instances"
  type        = string
}

variable "instance_profile_name" {
  description = "Name of the instance profile"
  type        = string
}

variable "ecs_cluster_name" {
  description = "ECS Cluster name for the instances"
  type        = string
}

variable "ecs_instance_name" {
  description = "ECS instance name for the instances"
  type        = string
}

variable "ecs_task_execution_role_arn" {
  description = "The ARN of the ECS Task Execution Role"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the Target Group"
  type        = string
}

variable "lb_listener_arn" {
  description = "ARN of the Load Balancer Listener"
  type        = string
}

variable "min_size" {
  description = "Minimum number of instances"
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances"
  type        = number
}

variable "desired_capacity" {
  description = "Desired number of instances"
  type        = number
}

variable "subnets" {
  description = "List of subnets for the Auto Scaling Group"
  type        = list(string)
}
