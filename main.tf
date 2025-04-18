provider "aws" {
  region = "us-east-1"
}
provider "aws" {
  region = "us-west-2"
}

module "dynamodb" {
  source      = "./modules/dynamodb"
  table_name  = var.table_name
}

module "lambda" {
  source      = "./modules/lambda"
  table_name  = var.table_name
}

module "api_gateway" {
  source      = "./modules/api_gateway"
  lambda_arn  = module.lambda.lambda_arn
}

output "api_gateway_api_id" {
  value = module.api_gateway.api_id
}

output "api_gateway_resource_id" {
  value = module.api_gateway.resource_id
}

output "api_gateway_method_id" {
  value = module.api_gateway.method_id
}
