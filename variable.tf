variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "add_user_zip_file" {
  description = "Path to the Lambda function zip file"
  type        = string
  default     = "add_user.zip"
}

variable "get_user_zip_file" {
  description = "Path to the Lambda function zip file"
  type        = string
  default     = "get_user.zip"
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  type        = string
  default     = "serverless_workshop_intro"
}

variable "dynamodb_hash_key" {
  description = "Name of the partition key for DynamoDB"
  type        = string
  default     = "_id"
}

variable "dynamodb_hash_key_type" {
  description = "Type of the partition key for DynamoDB"
  type        = string
  default     = "S"
}

variable "iam_role_name" {
  description = "The name of the IAM role for Lambda execution"
  type        = string
  default     = "lambda_execution_role"
}

variable "api_name" {
  description = "The name of the API Gateway"
  type        = string
  default     = "REST-API"
}

variable "api_description" {
  description = "Description of the API Gateway"
  type        = string
  default     = "API for accessing DynamoDB items"
}
