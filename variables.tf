# Variables globales
variable "vpc_name" {
  description = "The name of the VPC"
  default     = "kc-vpc-pf-bryan"
}

variable "subnet_name" {
  description = "The name of the subnet"
  default     = "kc-subnet-pf-bryan"
}

variable "availability_zone" {
  description = "List of Availability Zone"
  type        = string
  default     = "eu-west-1a"
}

variable "sg_name" {
  description = "Security group name"
  type        = string
  default     = "kc-sg-pf-bryan"
}