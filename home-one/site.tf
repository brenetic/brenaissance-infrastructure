provider "netlify" {
  token = "${data.aws_kms_secrets.netlify_token.plaintext["netlify_token"]}"
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
