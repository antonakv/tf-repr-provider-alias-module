terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.2"
    }
  }
}

provider "aws" {
  alias  = "aws-frankfurt"
  region = "eu-central-1"
}

provider "aws" {
  region = "us-east-1"
}

module "mymodule" {
    source = "github.com/antonakv/tf-repr-alias-module/mymodule"
}

resource "aws_dynamodb_table" "dynamodb-table-1" {
  name           = "UserTable"
  billing_mode   = "PROVISIONED"
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "UserId"
  range_key      = "UserTitle"

  provider = aws.aws-frankfurt

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "UserTitle"
    type = "S"
  }

  tags = {
    Name = "dynamodb-table-user"
  }
}

resource "aws_dynamodb_table" "dynamodb-table-2" {
  name           = "UserTable"
  billing_mode   = "PROVISIONED"
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "UserId"
  range_key      = "UserTitle"

  provider = aws

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "UserTitle"
    type = "S"
  }

  tags = {
    Name = "dynamodb-table-user"
  }
}
