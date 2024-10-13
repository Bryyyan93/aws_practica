provider "aws" {
  region = var.region
}

# Módulo de VPC
module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr_block       = var.vpc_cidr_block
  public_subnet_a_cidr = var.public_subnet_a_cidr
  public_subnet_b_cidr = var.public_subnet_b_cidr
  availability_zone_a  = var.availability_zone_a
  availability_zone_b  = var.availability_zone_b
  vpc_name             = var.vpc_name
  gateway_name         = var.gateway_name
  public_subnet_a_name = var.public_subnet_a_name
  public_subnet_b_name = var.public_subnet_b_name
  route_table_name     = var.route_table_name
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
  vpc_id = module.vpc.vpc_id
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
  source                      = "./modules/autoscaling"
  ami_id                      = data.aws_ami.latest_amazon_linux.id # Aquí se usa .id en lugar del bloque completo
  instance_type               = var.instance_type
  security_group_id           = module.security_group.security_group_id
  instance_profile_name       = module.iam.instance_profile_name # Aquí usamos el output del módulo IAM
  ecs_cluster_name            = var.ecs_cluster_name
  ecs_instance_name           = var.ecs_instance_name
  ecs_task_execution_role_arn = module.iam.ecs_task_execution_role_arn # Pasar el ARN desde el módulo IAM
  target_group_arn            = module.alb.target_group_arn            # Pasar el ARN del Target Group desde el módulo alb
  lb_listener_arn             = module.alb.listener_arn
  min_size                    = var.min_size
  max_size                    = var.max_size
  desired_capacity            = var.desired_capacity
  cpu_target                  = var.cpu_target
  cd_bef_red                  = var.cd_bef_red
  cd_bef_add                  = var.cd_bef_add
  subnets                     = [module.vpc.public_subnet_a_id, module.vpc.public_subnet_b_id]
}
