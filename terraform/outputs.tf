# VPC Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.vpc.public_subnet_ids
}

# ECS Outputs
output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = module.ecs.cluster_name
}

output "backend_task_definition_arn" {
  description = "ARN of the backend task definition"
  value       = module.ecs.backend_task_definition_arn
}

output "frontend_task_definition_arn" {
  description = "ARN of the frontend task definition"
  value       = module.ecs.frontend_task_definition_arn
}

# RDS Outputs
output "database_endpoint" {
  description = "Endpoint of the RDS instance"
  value       = module.rds.db_instance_endpoint
}

output "database_name" {
  description = "Name of the database"
  value       = module.rds.db_name
}

output "database_username" {
  description = "Master username of the database"
  value       = module.rds.db_username
}

output "database_password_secret_arn" {
  description = "ARN of the secret containing the database password"
  value       = module.rds.db_password_secret_arn
}

# S3 Outputs
output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = module.s3.bucket_id
}

output "s3_bucket_domain_name" {
  description = "Domain name of the S3 bucket"
  value       = module.s3.bucket_domain_name
} 