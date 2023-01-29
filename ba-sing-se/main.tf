locals {
  service = "ba-sing-se"
  region  = "eu-west-2"
}

provider "aws" {
  version     = ">= 2.17.0"
  max_retries = 1
  region      = "eu-west-2"
}

terraform {
  required_version = "0.12.28"

  backend "s3" {
    bucket  = "ba-sing-se-tfstate"
    key     = "ba-sing-se.tfstate"
    region  = "eu-west-2"
    encrypt = true
  }
}
