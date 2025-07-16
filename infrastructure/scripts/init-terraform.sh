#!/bin/bash

# Set variables
BUCKET_NAME="terraform-state-complete-pipeline"
DYNAMODB_TABLE="terraform-state-lock"
REGION="us-east-1"

# Create S3 bucket
echo "Creating S3 bucket for Terraform state..."
aws s3api create-bucket \
    --bucket $BUCKET_NAME \
    --region $REGION

# Enable versioning
aws s3api put-bucket-versioning \
    --bucket $BUCKET_NAME \
    --versioning-configuration Status=Enabled

# Enable encryption
aws s3api put-bucket-encryption \
    --bucket $BUCKET_NAME \
    --server-side-encryption-configuration \
    '{"Rules": [{"ApplyServerSideEncryptionByDefault": {"SSEAlgorithm": "AES256"}}]}'

# Create DynamoDB table for state locking
echo "Creating DynamoDB table for state locking..."
aws dynamodb create-table \
    --table-name $DYNAMODB_TABLE \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
    --region $REGION

echo "Terraform backend infrastructure setup complete!" 