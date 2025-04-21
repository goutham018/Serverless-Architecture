variable "region" {
  description = "aws region name"
  type        = string
}

variable "api_name" {
  description = "The name of the API Gateway"
  type        = string
}

variable "api_description" {
  description = "A description for the API Gateway"
  type        = string
}

variable "get_users_lambda_arn" {
  description = "The ARN of the Lambda function to be triggered by the API"
  type        = string
}