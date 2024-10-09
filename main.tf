# Módulo VPC para subnets públicas
module "vpc" {
  source = "./modules/vpc"
}

# Módulo ECS Cluster
module "ecs_cluster" {
  source = "./modules/ecs_cluster"
}

# Módulo NGINX Service en ECS
module "nginx_service" {
  source      = "./modules/nginx_service"
  cluster_id  = module.ecs_cluster.cluster_id
  subnets     = module.vpc.public_subnets
  vpc_id      = module.vpc.vpc_id
  ecs_sg_id   = module.vpc.ecs_sg_id
}