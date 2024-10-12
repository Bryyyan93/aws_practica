################### Definición de variables ######################
###############################################################
# Estas variables te permiten parametrizar el despliegue de tu infraestructura
# define el rango de direcciones IP de la VPC
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

# Define el bloque de CIDR para la subnet pública A
variable "public_subnet_a_cidr" {
  description = "CIDR block for the public subnet A"
  type        = string
}

# Define el bloque de CIDR para la subnet pública B
variable "public_subnet_b_cidr" {
  description = "CIDR block for the public subnet B"
  type        = string
}

# Define la zona de disponibilidad (AZ) donde se ubicará la subnet A
variable "availability_zone_a" {
  description = "Availability Zone for subnet A"
  type        = string
}

# Define la zona de disponibilidad (AZ) donde se ubicará la subnet B
variable "availability_zone_b" {
  description = "Availability Zone for subnet B"
  type        = string
}
################ Definición de nombre #############
# Nombre que se asignará a la VPC para identificarlo en AWS
variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

# Nombre que se asignará al Internet Gateway para identificarlo en AWS
variable "gateway_name" {
  description = "The name of the Internet Gateway"
  type        = string
}

# Nombre que se asignará a la subnet A para identificarla en AWS
variable "public_subnet_a_name" {
  description = "Name of the subnet a"
  type = string
}

# Nombre que se asignará a la subnet B para identificarla en AWS
variable "public_subnet_b_name" {
  description = "Name of the subnet b"
  type = string
}

# Nombre que se asignará a la tabla de rutas, define como se enruta el trafico en la red
variable "route_table_name" {
  description = "Name of the route table"
  type = string
}
