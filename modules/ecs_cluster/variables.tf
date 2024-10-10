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