################### Definición de Output ######################
###############################################################
# Devuelve el nombre del perfil de instancia (Instance Profile) asociado a las instancias EC2. 
output "instance_profile_name" {
  value = aws_iam_instance_profile.ecs_instance_profile.name
}

# Devuelve el ARN del rol de ejecución de tareas ECS (ECS Task Execution Role).
output "ecs_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}

