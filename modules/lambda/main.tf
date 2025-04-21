# modules/lambda/main.tf

resource "aws_lambda_function" "add_sample_data" {
  function_name = "m1-add-sample-data"
  runtime       = "python3.10"
  role          = var.lambda_execution_role_arn
  handler       = "add_user.lambda_handler"

  filename      = var.add_user_zip_file

  environment {
    variables = {
      TABLE_NAME = var.dynamodb_table_name
    }
  }
}

resource "aws_lambda_function" "get_users" {
  function_name = "get-users"
  runtime       = "python3.10"
  role          = var.lambda_execution_role_arn
  handler       = "get_user.lambda_handler"

  filename      = var.get_user_zip_file

  environment {
    variables = {
      TABLE_NAME = var.dynamodb_table_name
    }
  }
}

output "add_sample_data_lambda_arn" {
  value = aws_lambda_function.add_sample_data.arn
}

output "get_users_lambda_arn" {
  value = aws_lambda_function.get_users.arn
}

resource "aws_iam_role" "lambda_execution_role" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect    = "Allow"
        Sid       = ""
      }
    ]
  })
}

# Attach DynamoDB Full Access policy
resource "aws_iam_role_policy_attachment" "lambda_dynamodb_full_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
  role       = aws_iam_role.lambda_execution_role.name
}

# Attach DynamoDB Read-Only Access policy
resource "aws_iam_role_policy_attachment" "lambda_dynamodb_readonly_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBReadOnlyAccess"
  role       = aws_iam_role.lambda_execution_role.name
}

# Attach Lambda Basic Execution policy for CloudWatch Logs
resource "aws_iam_role_policy_attachment" "lambda_basic_execution_role" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_execution_role.name
}



output "lambda_execution_role_arn" {
  value = aws_iam_role.lambda_execution_role.arn
}