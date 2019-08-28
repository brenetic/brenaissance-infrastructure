locals {
  account = "${data.aws_kms_secrets.account_number.plaintext["account_number"]}"
  service = "notes"
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
    bucket  = "notes-tfstate"
    key     = "notes.tfstate"
    region  = "eu-west-2"
    encrypt = true
  }
}

data "aws_kms_secrets" "account_number" {
  secret {
    name    = "account_number"
    payload = "AQICAHiqGtTMHU0w6zM2AUzUl6QjIhh4bKxo5wwDovph0CfB/wHSIdcnkEwXHpYz3svFDzFIAAAAajBoBgkqhkiG9w0BBwagWzBZAgEAMFQGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMWDqezJ39ovlHlM13AgEQgCeGM0d6/5277Bdp3jyofjgGgO+Ud9TT+uuaYetCDF2PixDznDrvWoY="
  }
}
