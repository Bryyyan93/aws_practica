# Llamada al módulo VPC
module "vpc" {
  source            = "./modules/vpc"
  vpc_cidr          = "10.0.0.0/16"
  subnet_cidr       = "10.0.1.0/24"
  vpc_name          = var.vpc_name
  subnet_name       = var.subnet_name
  availability_zones = var.availability_zones
  route_table_name  = var.route_table_name
}

# Llamada al módulo Security Group
module "security_group" {
  source     = "./modules/security_group"
  vpc_id     = module.vpc.vpc_id
  local_cidr = "${chomp(data.http.my_ip.response_body)}/32" # Cambia por tu red local # Permitir el acceso ssh
  vpc_cidr   = "10.0.0.0/16"
  sg_name    = var.sg_name
}


# Llamada al módulo ecs_cluster
module "ecs_cluster" {
  vpc_id     = module.vpc.vpc_id
  source = "./modules/ecs_cluster"
  cluster_name = var.cluster_name
  containerInsights = var.containerInsights
  target_group_arn  = module.nginx_service.target_group_arn
  #aws_lb_target_group.nginx_tg.arn  # Pasa el Target Group ARN aquí

  #subnets = module.vpc.subnet_ids 
  subnets = module.vpc.public_subnet_ids
  security_group_id = module.security_group.security_group_id
  service_name = "kc-ecs-service-pf-bryan"
  desired_count = 2
  task_definition = module.nginx_service.task_definition_arn # module.nginx_service.task_definition.id
  #task_definition = "arn:aws:ecs:eu-west-1:921108067704:task-definition/kc-td-bryan:1"
  tags = {
    Enviroment = "dev"
  }
}

# Llamar al módulo ecs_iam_roles
module "ecs_iam_roles" {
  source = "./modules/ecs_iam_roles"
}

# 
module "nginx_service" {
  source                = "./modules/nginx_service"
  cluster_id            = module.ecs_cluster.ecs_cluster_id
  task_family           = "nginx-task-family"
  cpu                   = 256
  memory                = 512
  container_cpu         = 256
  container_memory      = 512
  execution_role_arn    = module.ecs_iam_roles.ecs_task_execution_role_arn
  task_role_arn         = module.ecs_iam_roles.ecs_task_role_arn
  service_name          = "nginx-service"
  desired_count         = 2
  subnets               = module.vpc.public_subnet_ids
  security_group_id     = module.security_group.security_group_id
  alb_security_group_id = module.security_group.security_group_id
  alb_name              = "nginx-alb"
  target_group_name     = "nginx-target-group"
  vpc_id                = module.vpc.vpc_id

  tags = {
    Environment = "dev"
  }
}