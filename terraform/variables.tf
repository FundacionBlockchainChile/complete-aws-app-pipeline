variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "complete-pipeline"
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

# Network Configuration
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

# ECS Configuration
variable "backend_cpu" {
  description = "CPU units for the backend task"
  type        = number
  default     = 256
}

variable "backend_memory" {
  description = "Memory for the backend task"
  type        = number
  default     = 512
}

variable "frontend_cpu" {
  description = "CPU units for the frontend task"
  type        = number
  default     = 256
}

variable "frontend_memory" {
  description = "Memory for the frontend task"
  type        = number
  default     = 512
}

# Database Configuration
variable "postgres_version" {
  description = "PostgreSQL version"
  type        = string
  default     = "14.7"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Allocated storage for RDS in GB"
  type        = number
  default     = 20
}

# Container Images
variable "backend_image" {
  description = "Docker image for backend"
  type        = string
  default     = "backend"  # Will be overridden in tfvars
}

variable "frontend_image" {
  description = "Docker image for frontend"
  type        = string
  default     = "frontend"  # Will be overridden in tfvars
} 