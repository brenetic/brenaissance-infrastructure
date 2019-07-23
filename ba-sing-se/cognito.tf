resource "aws_cognito_user_pool" "ba_sing_se_user_pool" {
  name = "${local.service}-user-pool"

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

resource "aws_cognito_user_pool_client" "ba_sing_se_client" {
  name = "${local.service}-client"

  user_pool_id = "${aws_cognito_user_pool.ba_sing_se_user_pool.id}"

  generate_secret     = false
  explicit_auth_flows = ["ADMIN_NO_SRP_AUTH"]
}

resource "aws_cognito_user_pool_domain" "ba_sing_se_pool_domain" {
  domain       = "${local.service}"
  user_pool_id = "${aws_cognito_user_pool.ba_sing_se_user_pool.id}"
}
