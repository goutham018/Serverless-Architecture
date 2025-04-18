resource "aws_dynamodb_table" "user_data_table" {
  name           = var.table_name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "userid"

  attribute {
    name = "userid"
    type = "S"
  }

  tags = {
    Name = "UserDataTable"
  }
}
