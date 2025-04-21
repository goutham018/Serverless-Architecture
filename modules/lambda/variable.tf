variable "lambda_execution_role_arn" {
  description = "The ARN of the IAM role for Lambda execution"
  type        = string
}

variable "add_user_zip_file" {
  description = "The path to the Lambda function zip file"
  type        = string
}


variable "get_user_zip_file" {
  description = "The path to the Lambda function zip file"
  type        = string
}

variable "dynamodb_table_name" {
  description = "The DynamoDB table name"
  type        = string
}


variable "role_name" {
  description = "The name of the IAM role for Lambda"
  type        = string
}