################### Definición de variables ######################
###############################################################
# ID de la AMI (Amazon Machine Image) que se utilizará para lanzar las instancias EC2.
variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

# Tipo de instancia EC2 a utilizar (por ejemplo, t2.micro, t3.medium).
variable "instance_type" {
  description = "Instance type for EC2"
  type        = string
}

# ID del grupo de seguridad asociado a las instancias.
variable "security_group_id" {
  description = "ID of the security group for the instances"
  type        = string
}

# Nombre del perfil de instancia asociado a las instancias EC2.
variable "instance_profile_name" {
  description = "Name of the instance profile"
  type        = string
}

# Nombre del clúster ECS donde las instancias se registrarán.
variable "ecs_cluster_name" {
  description = "ECS Cluster name for the instances"
  type        = string
}

# Nombre que se le dará a las instancias que se ejecuten en ECS.
variable "ecs_instance_name" {
  description = "ECS instance name for the instances"
  type        = string
}

# ARN del rol de ejecución de tareas ECS.
variable "ecs_task_execution_role_arn" {
  description = "The ARN of the ECS Task Execution Role"
  type        = string
}

# ARN del Target Group al que las instancias estarán asociadas.
variable "target_group_arn" {
  description = "ARN of the Target Group"
  type        = string
}

# ARN del listener del Load Balancer.
variable "lb_listener_arn" {
  description = "ARN of the Load Balancer Listener"
  type        = string
}

# Tamaño mínimo del grupo de Auto Scaling.
variable "min_size" {
  description = "Minimum number of instances"
  type        = number
}

# Tamaño máximo del grupo de Auto Scaling.
variable "max_size" {
  description = "Maximum number of instances"
  type        = number
}

# Capacidad deseada del grupo de Auto Scaling.
variable "desired_capacity" {
  description = "Desired number of instances"
  type        = number
}

# Lista de subnets donde el Auto Scaling Group desplegará las instancias EC2.
variable "subnets" {
  description = "List of subnets for the Auto Scaling Group"
  type        = list(string)
}
