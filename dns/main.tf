locals {
  zone    = "brenetic.com"
  domain  = "brenetic.com"
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

resource "aws_route53_zone" "brenetic" {
  name = "${local.zone}"
}

output "brenetic_name_servers" {
  value = "${aws_route53_zone.brenetic.name_servers}"
}

module "records" {
  source = "./records"

  zone_id = "${aws_route53_zone.brenetic.zone_id}"
  domain  = "${local.domain}"
}
