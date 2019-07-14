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
  required_version = "0.12.3"

   backend "s3" {
    bucket  = "home-one-tfstate"
    key     = "home-one.tfstate"
    region  = "eu-west-2"
    encrypt = true
  }
}

data "aws_kms_secrets" "netlify_token" {
  secret {
    name    = "netlify_token"
    payload = "AQICAHiqGtTMHU0w6zM2AUzUl6QjIhh4bKxo5wwDovph0CfB/wG/PR+t+t0RPaiaLFJCQsygAAAAojCBnwYJKoZIhvcNAQcGoIGRMIGOAgEAMIGIBgkqhkiG9w0BBwEwHgYJYIZIAWUDBAEuMBEEDKQe/kaScBqjKuEiOwIBEIBbGfh3zlWodXHAtM7x9d5IhPs0l8oxJSLMWHfsAnDGQNJs7zvfPtq7QZdS1pvfFYB/pKxW0+GuUdIxSizTzblQnIvrwKCef9mzGu13LG85ac1dHnkXR0WepqiqJg=="
  }
}
