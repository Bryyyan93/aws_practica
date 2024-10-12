################### Definición de Output ######################
###############################################################
# Devuelve el ID del grupo de seguridad asociado a las instancias ECS.
output "security_group_id" {
  value = aws_security_group.ecs_sg.id
}
