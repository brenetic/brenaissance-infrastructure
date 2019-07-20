data "aws_kms_secrets" "ba_sing_se_gateway" {
  secret {
    name    = "gateway"
    payload = "AQICAHiqGtTMHU0w6zM2AUzUl6QjIhh4bKxo5wwDovph0CfB/wE3X4MsXsEfjcMuty8SbM9ZAAAAnTCBmgYJKoZIhvcNAQcGoIGMMIGJAgEAMIGDBgkqhkiG9w0BBwEwHgYJYIZIAWUDBAEuMBEEDOJXuLeE06C/lGQgTQIBEIBWY+BcUrkoxXvE7AT33sWBKznMDFMG2/2JyL+LApFRUTNAYFVnLEECbX3df5oKgEVdwbXHjjky0KUMybbifWkY2NmcdGviLNdHBUUEhpmIboQ7vguoPMA="
  }
}

resource "aws_route53_record" "ba_sing_se" {
  zone_id = "${var.zone_id}"
  name    = "ba-sing-se.${var.domain}"
  type    = "CNAME"
  ttl     = "60"

  records = ["${data.aws_kms_secrets.ba_sing_se_gateway.plaintext["gateway"]}"]
}
