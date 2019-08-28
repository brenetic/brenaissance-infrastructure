resource "aws_cognito_user_pool" "user_pool" {
  name = "${local.organisation}-user-pool"

  admin_create_user_config {
    allow_admin_create_user_only = false
  }

  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]

  password_policy {
    minimum_length    = 10
    require_lowercase = false
    require_numbers   = true
    require_symbols   = false
    require_uppercase = true
  }
}
