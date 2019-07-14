locals {
  service = "dns"
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
    bucket  = "dns-tfstate"
    key     = "dns.tfstate"
    region  = "eu-west-2"
    encrypt = true
  }
}
