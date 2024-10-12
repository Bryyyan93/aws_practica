variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "subnets" {
  description = "List of subnets for the ALB"
  type        = list(string)
}

variable "security_group_id" {
  description = "ID of the security group to associate with the ALB"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the ALB"
  type        = string
}

variable "target_group_name" {
  description = "Name of the Target Group for the ALB"
  type        = string
}
