resource "aws_dynamodb_table" "ba_sing_se_properties" {
  name         = "${local.service}-properties"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "userId"
  range_key    = "propertyId"

  attribute {
    name = "userId"
    type = "S"
  }

  attribute {
    name = "propertyId"
    type = "S"
  }

  server_side_encryption {
    enabled = true
  }
}
