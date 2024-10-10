variable "vpc_id" {
  description = "VPC ID where the security group will be created"
  type        = string
}

variable "local_cidr" {
  description = "Local CIDR block allowed for SSH access"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC for outbound traffic"
  type        = string
}

variable "sg_name" {
  description = "Name of the security group"
  type        = string
}
