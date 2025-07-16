variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "IDs of the subnets to place the ECS tasks in"
  type        = list(string)
}

variable "backend_cpu" {
  description = "CPU units for the backend task"
  type        = number
}

variable "backend_memory" {
  description = "Memory for the backend task"
  type        = number
}

variable "frontend_cpu" {
  description = "CPU units for the frontend task"
  type        = number
}

variable "frontend_memory" {
  description = "Memory for the frontend task"
  type        = number
}

variable "backend_image" {
  description = "Docker image for backend"
  type        = string
}

variable "frontend_image" {
  description = "Docker image for frontend"
  type        = string
} 