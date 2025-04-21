# modules/dynamodb/main.tf

resource "aws_dynamodb_table" "serverless_workshop_intro" {
  name           = var.table_name
  hash_key       = var.hash_key
  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = var.hash_key
    type = var.hash_key_type
  }

  attribute {
    name = "Userid"
    type = "S"
  }

  attribute {
    name = "FullName"
    type = "S"
  }

global_secondary_index {
    name               = "UseridIndex"
    hash_key           = "Userid"
    projection_type    = "ALL"
  }

  global_secondary_index {
    name               = "FullNameIndex"
    hash_key           = "FullName"
    projection_type    = "ALL"
  }
}


output "table_name" {
  value = aws_dynamodb_table.serverless_workshop_intro.name
}