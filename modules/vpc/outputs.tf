output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.this.id
}

/*
output "subnet_id" {
  description = "ID of the private subnet"
  value       = aws_subnet.private_subnet.id
}
*/
output "subnet_ids" {
  description = "Lista de IDs de las subnets privadas"
  value =  [for s in aws_subnet.private_subnet : s.id]  # Devuelve una lista de todas las subnets
  #value       = aws_subnet.private_subnet[*].id  # Devuelve una lista de todas las subnets creadas
}
