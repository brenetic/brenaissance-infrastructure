locals {
  account = "${data.aws_ssm_parameter.account_number.value}"
  service = "notes"
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
    bucket  = "notes-tfstate"
    key     = "notes.tfstate"
    region  = "eu-west-2"
    encrypt = true
  }
}

data "aws_ssm_parameter" "account_number" {
  name = "account-number"
}
