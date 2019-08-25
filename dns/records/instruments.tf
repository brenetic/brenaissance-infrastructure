resource "aws_route53_record" "instruments" {
  zone_id = "${var.zone_id}"
  name    = "instruments.${var.domain}"
  type    = "CNAME"
  ttl     = "60"

  records = ["${data.aws_ssm_parameter.instruments_netlify_domain.value}"]
}

data "aws_ssm_parameter" "instruments_netlify_domain" {
  name = "instruments-netlify-domain"
}
