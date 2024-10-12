variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_a_cidr" {
  description = "CIDR block for the public subnet A"
  type        = string
}

variable "public_subnet_b_cidr" {
  description = "CIDR block for the public subnet B"
  type        = string
}

variable "availability_zone_a" {
  description = "Availability Zone for subnet A"
  type        = string
}

variable "availability_zone_b" {
  description = "Availability Zone for subnet B"
  type        = string
}

# Names of the instances
variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "gateway_name" {
  description = "The name of the Internet Gateway"
  type        = string
}

variable "public_subnet_a_name" {
  description = "Name of the subnet a"
}

variable "public_subnet_b_name" {
  description = "Name of the subnet b"
}

variable "route_table_name" {
  description = "Name of the route table"
}
