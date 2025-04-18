resource "aws_lambda_function" "my_lambda" {
  function_name = "my_lambda_function"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  role          = aws_iam_role.lambda_exec_role.arn
  filename      = "lambda_function.zip"

  environment {
    variables = {
      TABLE_NAME = var.table_name
    }
  }
}

resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com",
      },
    }],
  })

  inline_policy {
    name   = "lambda_policy"
    policy = jsonencode({
      Version = "2012-10-17",
      Statement = [
        {
          Action = [
            "dynamodb:PutItem",
            "dynamodb:BatchWriteItem",
          ],
          Effect   = "Allow",
          Resource = "*",
        },
      ],
    })
  }
}

output "lambda_arn" {
  value = aws_lambda_function.my_lambda.arn
}
