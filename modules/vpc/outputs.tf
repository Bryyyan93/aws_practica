################### Definición de Output ######################
###############################################################
# Estas instancias pueden ser usadas por otros modulos
# Devuelve el ID de la VPC creada.
output "vpc_id" {
  value = aws_vpc.main.id
}

# Devuelve el ID de la subnet pública A.
output "public_subnet_a_id" {
  value = aws_subnet.public_subnet_a.id
}

# Devuelve el ID de la subnet pública B.
output "public_subnet_b_id" {
  value = aws_subnet.public_subnet_b.id
}