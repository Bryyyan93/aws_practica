################### Definición de variables ######################
###############################################################
# ID de la VPC donde se desplegará el Application Load Balancer (ALB)
variable "vpc_id" {
  description = "VPC ID for the ALB"
  type        = string
}