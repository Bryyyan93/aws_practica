# Llamada al módulo VPC
module "vpc" {
  source            = "./modules/vpc"
  vpc_cidr          = "10.0.0.0/16"
  subnet_cidr       = "10.0.1.0/24"
  vpc_name          = var.vpc_name
  subnet_name       = var.subnet_name
  availability_zone = var.availability_zone
  route_table_name  = var.route_table_name
}

# Llamada al módulo Security Group
module "security_group" {
  source     = "./modules/security_group"
  vpc_id     = module.vpc.vpc_id
  local_cidr = "${chomp(data.http.my_ip.response_body)}/32" # Cambia por tu red local
  vpc_cidr   = "10.0.0.0/16"
  sg_name    = var.sg_name
}


# Llamada al módulo ecs_cluster
module "ecs_cluster" {
  source = "./modules/ecs_cluster"
  cluster_name = var.cluster_name
  containerInsights = var.containerInsights

  subnets = [ module.vpc.subnet_id ]
  security_group_id = module.security_group.security_group_id
  service_name = "kc-fargate-service"
  desired_count = 1
  task_definition = "arn:aws:ecs:eu-west-1:921108067704:task-definition/kc-td-bryan:1"
  tags = {
    Enviroment = "dev"
  }
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
  execution_role_arn    = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn         = aws_iam_role.ecsTaskRole.arn
  service_name          = "nginx-service"
  desired_count         = 2
  subnets               = module.vpc.subnet_id
  security_group_id     = module.security_group.security_group_id
  alb_security_group_id = module.security_group.security_group_id
  alb_name              = "nginx-alb"
  target_group_name     = "nginx-target-group"
  vpc_id                = module.vpc.vpc_id

  tags = {
    Environment = "dev"
  }
}