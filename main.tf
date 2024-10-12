provider "aws" {
  region = var.region
}

# Módulo de VPC
module "vpc" {
  source                = "./modules/vpc"
  vpc_cidr_block        = var.vpc_cidr_block
  public_subnet_a_cidr  = var.public_subnet_a_cidr
  public_subnet_b_cidr  = var.public_subnet_b_cidr
  availability_zone_a   = var.availability_zone_a
  availability_zone_b   = var.availability_zone_b
  vpc_name              = "main-vpc"
  gateway_name          = "main-gateway"
}

# Módulo de ECS Cluster
module "ecs_cluster" {
  source       = "./modules/ecs_cluster"
  cluster_name = var.ecs_cluster_name
}

# Módulo IAM para la Instance Profile
module "iam" {
  source = "./modules/iam"
}

# Módulo Security Group
module "security_group" {
  source = "./modules/security_group"
  vpc_id            = module.vpc.vpc_id
}

# Módulo de Application Load Balancer (ALB)
module "alb" {
  source            = "./modules/alb"
  alb_name          = var.alb_name
  subnets           = [module.vpc.public_subnet_a_id, module.vpc.public_subnet_b_id]
  security_group_id = module.security_group.security_group_id
  vpc_id            = module.vpc.vpc_id
  target_group_name = var.target_group_name
}

# Módulo de Auto Scaling Group
module "autoscaling" {
  source                 = "./modules/autoscaling"
  ami_id                 = data.aws_ami.latest_amazon_linux.id # Aquí se usa .id en lugar del bloque completo
  instance_type          = var.instance_type
  security_group_id      = module.security_group.security_group_id
  instance_profile_name  = module.iam.instance_profile_name # Aquí usamos el output del módulo IAM
  ecs_cluster_name       = var.ecs_cluster_name
  min_size               = var.min_size
  max_size               = var.max_size
  desired_capacity       = var.desired_capacity
  subnets                = [module.vpc.public_subnet_a_id, module.vpc.public_subnet_b_id]
}
