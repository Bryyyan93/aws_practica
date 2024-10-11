variable "cluster_name" {
    description = "Nombre del ecs cluster"
    type = string
}

variable "containerInsights" {
    description = "Habilitar container insights para el cluster"
}

variable "tags" {
    description = "Etiquetas aplicadas a los recursos"
    type = map(string)
}

variable "service_name" {
  description = "Nombre del servicio Fargate"
  type        = string
}

variable "desired_count" {
  description = "Número de tareas para ejecutar en el servicio"
  type        = number
  default     = 1
}

variable "task_definition" {
  description = "Definición de la tarea ECS"
  type        = string
}

variable "subnets" {
  description = "Subnets donde correrá el servicio ECS"
  type        = list(string)
}

variable "security_group_id" {
  description = "ID del Security Group para el ECS"
  type        = string
}

variable "target_group_arn" {
  description = "ARN del Target Group del ALB"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}


/*
variable "key_name" {
  description = "Nombre de la clave para acceder a las instancias vía SSH"
  type        = string
}
*/