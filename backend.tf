terraform {
  required_version = ">= 1.1.0"
  backend "s3" {
    bucket  = "my-s3-bucket-demo12345"
    key     = "goutham/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
