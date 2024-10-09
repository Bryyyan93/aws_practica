# Variables globales
variable "vpc_name" {
  description = "The name of the VPC"
  default     = "kc-vpc-pf-bryan"
}

variable "availability_zone" {
  description = "List of Availability Zones"
  type = string
  default = "eu-west-1"
}