terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.94.1"
    }
  }
}

provider "aws" {
  region = var.region
}

module "dynamodb" {
  source      = "./modules/dynamo-db"
  table_name  = var.dynamodb_table_name
  hash_key    = var.dynamodb_hash_key
  hash_key_type = var.dynamodb_hash_key_type
}

module "lambda" {
  source                = "./modules/lambda"
  lambda_execution_role_arn = module.lambda.lambda_execution_role_arn
  add_user_zip_file     = var.add_user_zip_file
  get_user_zip_file     = var.get_user_zip_file
  dynamodb_table_name   = module.dynamodb.table_name
  role_name = var.iam_role_name
}

# API Gateway module
module "api_gateway" {
  source                = "./modules/api-gateway"
  region                = var.region
  api_name              = var.api_name
  api_description       = var.api_description
  get_users_lambda_arn  = module.lambda.get_users_lambda_arn
}

output "api_invoke_url" {
  value = module.api_gateway.api_invoke_url
}