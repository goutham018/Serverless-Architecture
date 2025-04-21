# modules/dynamodb/variables.tf

variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
}

variable "hash_key" {
  description = "The name of the partition key"
  type        = string
}

variable "hash_key_type" {
  description = "The type of the partition key"
  type        = string
  default     = "S"
}