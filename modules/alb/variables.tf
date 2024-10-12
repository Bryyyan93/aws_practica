################### Definición de variables ######################
###############################################################
# Nombre del Application Load Balancer (ALB)
variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

# Lista de subnets donde se desplegará el ALB
variable "subnets" {
  description = "List of subnets for the ALB"
  type        = list(string)
}

# ID del grupo de seguridad asociado al ALB
variable "security_group_id" {
  description = "ID of the security group to associate with the ALB"
  type        = string
}

# ID de la VPC donde se desplegará el ALB
variable "vpc_id" {
  description = "VPC ID for the ALB"
  type        = string
}

# Nombre del Target Group asociado al ALB
variable "target_group_name" {
  description = "Name of the Target Group for the ALB"
  type        = string
}
