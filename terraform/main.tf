# VPC and Networking
module "vpc" {
  source = "./modules/vpc"

  project_name    = var.project_name
  environment     = var.environment
  vpc_cidr        = var.vpc_cidr
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones = ["${var.aws_region}a", "${var.aws_region}b"]
}

# ECS Cluster and Services
module "ecs" {
  source = "./modules/ecs"

  project_name    = var.project_name
  environment     = var.environment
  aws_region      = var.aws_region
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.public_subnet_ids
  
  backend_cpu     = var.backend_cpu
  backend_memory  = var.backend_memory
  frontend_cpu    = var.frontend_cpu
  frontend_memory = var.frontend_memory
  
  backend_image   = var.backend_image
  frontend_image  = var.frontend_image
}

# RDS Database
module "rds" {
  source = "./modules/rds"

  project_name    = var.project_name
  environment     = var.environment
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.public_subnet_ids
  depends_on      = [module.ecs]
  ecs_security_group_id = module.ecs.backend_security_group_id

  postgres_version   = var.postgres_version
  instance_class    = var.db_instance_class
  allocated_storage = var.db_allocated_storage
  database_name     = "${var.project_name}${var.environment}db"
  database_username = "dbadmin"
}

# S3 Storage
module "s3" {
  source = "./modules/s3"

  project_name      = var.project_name
  environment       = var.environment
  ecs_task_role_arn = module.ecs.task_execution_role_arn
  
  allowed_origins   = ["*"]  # Update this with your frontend domain in production
  
  lifecycle_rules = [
    {
      id              = "temp_files"
      status          = "Enabled"
      prefix          = "temp/"
      transition_days = 30
      storage_class   = "STANDARD_IA"
      expiration_days = 90
    }
  ]
} 