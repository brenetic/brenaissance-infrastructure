resource "aws_route53_record" "ba_sing_se" {
  zone_id = "${var.zone_id}"
  name    = "ba-sing-se.${var.domain}"
  type    = "CNAME"
  ttl     = "60"

  records = ["${data.aws_ssm_parameter.ba_sing_se_api_gateway.value}"]
}

data "aws_ssm_parameter" "ba_sing_se_api_gateway" {
  name = "ba-sing-se-api-endpoint"
}
