locals {
  service = "home-one"
  region  = "eu-west-2"
}

provider "aws" {
  version     = ">= 2.17.0"
  max_retries = 1
  region      = "eu-west-2"
}

terraform {
  required_version = "0.12.3"

   backend "s3" {
    bucket  = "home-one-tfstate"
    key     = "home-one.tfstate"
    region  = "eu-west-2"
    encrypt = true
  }
}
