locals {
  organsiation = "brenaissance"
  region       = "eu-west-2"
}

provider "aws" {
  version     = ">= 2.17.0"
  max_retries = 1
  region      = "eu-west-2"
}

terraform {
  required_version = "0.12.3"

   backend "s3" {
    bucket  = "brenaissance-tfstate"
    key     = "brenaissance.tfstate"
    region  = "eu-west-2"
    encrypt = true
  }
}

 resource "aws_s3_bucket" "brenaissance-tfstate" {
  bucket = "${local.organsiation}-tfstate"
  region = "${local.region}"

   server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

   lifecycle {
    prevent_destroy = true
  }
}
