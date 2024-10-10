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

# Configuracion de ECS cluster
variable "cluster_name" {
  description = "Nombre del ECS cluster"
  type = string
  default = "kc-ecs-cluster-pf-bryan"
}

variable "route_table_name" {
  description = "Nombre de la tabla de rutas"
  type        = string
  default     = "my-private-route-table"
}

variable "containerInsights" {
  description = "Habilitar container Insigths"
  type = string
  default = "enabled"
}

