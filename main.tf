# Llamada al módulo VPC
module "vpc" {
  source            = "./modules/vpc"
  vpc_cidr          = "10.0.0.0/16"
  subnet_cidr       = "10.0.1.0/24"
  vpc_name          = "private-vpc"
  subnet_name       = "private-subnet"
  availability_zone = var.availability_zone
  route_table_name  = "private-route-table"
}

# Llamada al módulo Security Group
module "security_group" {
  source    = "./modules/security_group"
  vpc_id    = module.vpc.vpc_id
  local_cidr = "${chomp(data.http.my_ip.response_body)}/32"  # Cambia por tu red local
  vpc_cidr  = "10.0.0.0/16"
  sg_name   = "private-sg"
}
