locals {
  service = "instruments"
  region  = "eu-west-2"
}

provider "aws" {
  version     = ">= 2.17.0"
  max_retries = 1
  region      = "eu-west-2"
}

provider "netlify" {
  token = data.aws_ssm_parameter.netlify_token.value
}

terraform {
  required_version = "0.12.28"

   backend "s3" {
    bucket  = "instruments-tfstate"
    key     = "instruments.tfstate"
    region  = "eu-west-2"
    encrypt = true
  }
}

data "aws_ssm_parameter" "netlify_token" {
  name = "netlify-token"
}

resource "netlify_deploy_key" "key" {}

resource "netlify_site" "instruments" {
  name = local.service

  repo {
    repo_branch   = "main"
    command       = "HUGO_ENV=production hugo"
    deploy_key_id = netlify_deploy_key.key.id
    dir           = "public"
    provider      = "github"
    repo_path     = "brenetic/instruments"
  }
}
