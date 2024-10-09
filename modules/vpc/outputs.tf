output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.this.id
}

output "subnet_id" {
  description = "ID of the private subnet"
  value       = aws_subnet.private_subnet.id
}
