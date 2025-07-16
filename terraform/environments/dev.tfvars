project_name = "complete-pipeline"
environment  = "dev"
aws_region   = "us-east-1"

# Network Configuration
vpc_cidr            = "10.0.0.0/16"
public_subnet_cidr  = "10.0.1.0/24"

# ECS Configuration
backend_cpu     = 256
backend_memory  = 512
frontend_cpu    = 256
frontend_memory = 512

# Container Images
backend_image  = "489585378121.dkr.ecr.us-east-1.amazonaws.com/backend:dev"
frontend_image = "489585378121.dkr.ecr.us-east-1.amazonaws.com/frontend:dev"

# Database Configuration
postgres_version     = "14.18"
db_instance_class   = "db.t3.micro"
db_allocated_storage = 20 