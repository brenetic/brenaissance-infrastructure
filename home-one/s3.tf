 resource "aws_s3_bucket" "home-one-tfstate" {
  bucket = "${local.service}-tfstate"
  region = local.region

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
