variable "cluster_id" {
  description = "ID del ECS Cluster"
  type        = string
}

variable "task_family" {
  description = "Nombre de la familia de la task definition"
  type        = string
}

variable "cpu" {
  description = "CPU total asignado a la task definition"
  type        = number
}

variable "memory" {
  description = "Memoria total asignada a la task definition"
  type        = number
}

variable "container_cpu" {
  description = "CPU asignado al contenedor"
  type        = number
}

variable "container_memory" {
  description = "Memoria asignada al contenedor"
  type        = number
}

variable "execution_role_arn" {
  description = "ARN del rol de ejecución para la task definition"
  type        = string

}
output "task_definition_arn" {
  description = "ARN del Task Definition de NGINX"
  value       = aws_ecs_task_definition.nginx.arn
}

variable "task_role_arn" {
  description = "ARN del rol de tarea para la task definition"
  type        = string
}

variable "service_name" {
  description = "Nombre del servicio ECS"
  type        = string
}

variable "desired_count" {
  description = "Número de tareas NGINX que quieres ejecutar"
  type        = number
}

variable "subnets" {
  description = "Subnets para ejecutar el servicio ECS y el ALB"
  type        = list(string)
}

variable "security_group_id" {
  description = "ID del Security Group para el ECS Service"
  type        = string
}

variable "alb_security_group_id" {
  description = "ID del Security Group para el ALB"
  type        = string
}

variable "alb_name" {
  description = "Nombre del Application Load Balancer"
  type        = string
}

variable "target_group_name" {
  description = "Nombre del Target Group"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "tags" {
  description = "Etiquetas aplicadas a los recursos"
  type        = map(string)
}

