variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "subnet_name" {
  description = "Name of the private subnet"
  type        = string
}

variable "availability_zones" {
  description = "Availability Zone for the subnet"
  type        = list(string)
}

variable "route_table_name" {
  description = "Name of the route table"
  type        = string
}


