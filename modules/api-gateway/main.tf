resource "aws_api_gateway_rest_api" "serverless_rest_api" {
  name        = var.api_name
  description = var.api_description
}

resource "aws_api_gateway_resource" "users_resource" {
  rest_api_id = aws_api_gateway_rest_api.serverless_rest_api.id
  parent_id   = aws_api_gateway_rest_api.serverless_rest_api.root_resource_id
  path_part   = "users"
}

resource "aws_api_gateway_method" "get_users_method" {
  rest_api_id   = aws_api_gateway_rest_api.serverless_rest_api.id
  resource_id   = aws_api_gateway_resource.users_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_users_integration" {
  rest_api_id             = aws_api_gateway_rest_api.serverless_rest_api.id
  resource_id             = aws_api_gateway_resource.users_resource.id
  http_method             = aws_api_gateway_method.get_users_method.http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/${var.get_users_lambda_arn}/invocations"
}

resource "aws_api_gateway_stage" "serverless_api_stage" {
  stage_name    = "v1"
  rest_api_id   = aws_api_gateway_rest_api.serverless_rest_api.id
  deployment_id = aws_api_gateway_deployment.serverless_api_deployment.id
}


# Deploy the API
resource "aws_api_gateway_deployment" "serverless_api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.serverless_rest_api.id
  triggers    = {
    redeploy = "${timestamp()}"
  }

  depends_on = [
     aws_api_gateway_method.get_users_method,
     aws_api_gateway_integration.get_users_integration
  ]
}

# Add permission for API Gateway to invoke the Lambda function
resource "aws_lambda_permission" "allow_api_gateway_to_invoke_lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.get_users_lambda_arn
  principal     = "apigateway.amazonaws.com"
}

# Output the API invoke URL
output "api_invoke_url" {
  value = "${aws_api_gateway_stage.serverless_api_stage.invoke_url}/users"
}