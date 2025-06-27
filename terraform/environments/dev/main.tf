provider "aws" {
  region = var.aws_region
}

module "network" {
  source               = "../../modules/network"
  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs
}

module "security_groups" {
  source        = "../../modules/security_groups"
  project_name  = var.project_name
  vpc_id        = module.network.vpc_id
}

module "ecs" {
  source = "../../modules/ecs"

  project_name              = var.project_name
  container_image_appointment = var.container_image_appointment
  container_image_patient     = var.container_image_patient
  aws_region                  = var.aws_region
  public_subnet_ids           = module.network.public_subnet_ids
  private_subnet_ids          = module.network.private_subnet_ids
  vpc_id                      = module.network.vpc_id
  alb_sg_id                   = module.security_groups.alb_sg_id
  app_sg_id                   = module.security_groups.app_sg_id
}

