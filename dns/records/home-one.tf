data "aws_ssm_parameter" "brenetic_netlify_ip" {
  name = "brenetic-netlify-ip-address"
}

data "aws_ssm_parameter" "brenetic_netlify_domain" {
  name = "brenetic-netlify-host"
}

resource "aws_route53_record" "brenetic_web" {
  zone_id = "${var.zone_id}"
  name    = "${var.domain}"
  type    = "A"
  ttl     = "60"

  records = ["${data.aws_ssm_parameter.brenetic_netlify_ip.value}"]
}

resource "aws_route53_record" "www_brenetic_web" {
  zone_id = "${var.zone_id}"
  name    = "www.${var.domain}"
  type    = "CNAME"
  ttl     = "60"

  records = ["${data.aws_ssm_parameter.brenetic_netlify_domain.value}"]
}

resource "aws_route53_record" "brenetic_mx_record" {
  zone_id = "${var.zone_id}"
  name    = "${var.domain}"
  type    = "MX"
  ttl     = "60"

  records = ["1 ${data.aws_ssm_parameter.brenetic_mx_host.value}"]
}

data "aws_ssm_parameter" "brenetic_mx_host" {
  name = "brenetic-mx-host"
}

resource "aws_route53_record" "brenetic_keybase_txt" {
  zone_id = "${var.zone_id}"
  name    = "_keybase"
  type    = "TXT"
  ttl     = "60"

  records = ["${data.aws_ssm_parameter.brenetic_keybase_txt.value}"]
}

data "aws_ssm_parameter" "brenetic_keybase_txt" {
  name = "brenetic-keybase-txt"
}

resource "aws_route53_record" "brenetic_protonmail_txt" {
  zone_id = "${var.zone_id}"
  name    = "@"
  type    = "TXT"
  ttl     = "60"

  records = ["${data.aws_ssm_parameter.brenetic_protonmail_txt.value}"]
}

data "aws_ssm_parameter" "brenetic_protonmail_txt" {
  name = "brenetic-protonmail-txt"
}
