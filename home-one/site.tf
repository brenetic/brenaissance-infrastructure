locals {
  service = "brenetic"
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
    bucket  = "home-one-tfstate"
    key     = "home-one.tfstate"
    region  = "eu-west-2"
    encrypt = true
  }
}

provider "netlify" {
  token = "${data.aws_ssm_parameter.netlify_token.value}"
}

data "aws_ssm_parameter" "netlify_token" {
  name = "netlify-token"
}

resource "netlify_deploy_key" "key" {}

resource "netlify_site" "home-one" {
  name = "${local.service}"

  repo {
    repo_branch   = "master"
    command       = "npm run generate"
    deploy_key_id = "${netlify_deploy_key.key.id}"
    dir           = "dist"
    provider      = "github"
    repo_path     = "brenetic/home-one"
  }
}
