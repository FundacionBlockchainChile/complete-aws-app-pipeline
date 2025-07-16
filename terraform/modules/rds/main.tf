terraform {
  required_version = ">= 1.0.0"
}

# Security Group for RDS
resource "aws_security_group" "rds" {
  name        = "${var.project_name}-rds-sg"
  description = "Security group for RDS PostgreSQL"
  vpc_id      = var.vpc_id

  # Allow inbound traffic from ECS tasks
  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.ecs_security_group_id]
  }

  tags = {
    Name = "${var.project_name}-rds-sg"
    Environment = var.environment
    Tag = "complete-pipeline-exercise"
  }
}

# Subnet group for RDS
resource "aws_db_subnet_group" "main" {
  name        = "${var.project_name}-db-subnet-group"
  description = "DB subnet group for ${var.project_name}"
  subnet_ids  = var.subnet_ids

  tags = {
    Name = "${var.project_name}-db-subnet-group"
    Environment = var.environment
    Tag = "complete-pipeline-exercise"
  }
}

# Random password for RDS
resource "random_password" "db_password" {
  length  = 16
  special = false
}

# Store password in AWS Secrets Manager
resource "aws_secretsmanager_secret" "db_password" {
  name = "${var.project_name}/${var.environment}/db-password-${formatdate("YYYYMMDDhhmmss", timestamp())}"
  
  tags = {
    Name = "${var.project_name}-db-password"
    Environment = var.environment
    Tag = "complete-pipeline-exercise"
  }
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = random_password.db_password.result
}

# RDS PostgreSQL instance
resource "aws_db_instance" "main" {
  identifier = "${var.project_name}-${var.environment}-db"

  engine               = "postgres"
  engine_version       = var.postgres_version
  instance_class      = var.instance_class
  allocated_storage   = var.allocated_storage
  storage_type        = "gp2"

  db_name  = replace("${var.project_name}${var.environment}db", "-", "")
  username = var.database_username
  password = random_password.db_password.result

  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name

  multi_az               = var.environment == "prod" ? true : false
  publicly_accessible    = false
  skip_final_snapshot    = true

  backup_retention_period = var.environment == "prod" ? 7 : 1
  backup_window          = "03:00-04:00"
  maintenance_window     = "Mon:04:00-Mon:05:00"

  tags = {
    Name = "${var.project_name}-${var.environment}-db"
    Environment = var.environment
    Tag = "complete-pipeline-exercise"
  }
} 