data "aws_kms_secrets" "brenetic_netlify_ip" {
  secret {
    name    = "netlify_ip"
    payload = "AQICAHiqGtTMHU0w6zM2AUzUl6QjIhh4bKxo5wwDovph0CfB/wFK3jdszbThozT6lWlk4DldAAAAazBpBgkqhkiG9w0BBwagXDBaAgEAMFUGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMSAKsDfDU7fJ3ZL+sAgEQgCgCIBS8V7z38Ymg0xFkF9/B/bGzbyh0EMPWV0YZ4z2w1C9lG1k/9BAf"
  }
}

data "aws_kms_secrets" "brenetic_netlify_domain" {
  secret {
    name    = "netlify_domain"
    payload = "AQICAHiqGtTMHU0w6zM2AUzUl6QjIhh4bKxo5wwDovph0CfB/wFkaU08/OVDmtVSVQnbMdwcAAAAcjBwBgkqhkiG9w0BBwagYzBhAgEAMFwGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQM4wirbebStFXPtqe7AgEQgC+z8NegzszCPO+37tu6+zSoQP6jrgPNwqdoel8rFMCluYj8gMnUazsA25+z8apb6g=="
  }
}

resource "aws_route53_record" "brenetic_web" {
  zone_id = "${var.zone_id}"
  name    = "${var.domain}"
  type    = "A"
  ttl     = "60"

  records = ["${data.aws_kms_secrets.brenetic_netlify_ip.plaintext["netlify_ip"]}"]
}

resource "aws_route53_record" "www_brenetic_web" {
  zone_id = "${var.zone_id}"
  name    = "www.${var.domain}"
  type    = "CNAME"
  ttl     = "60"

  records = ["${data.aws_kms_secrets.brenetic_netlify_domain.plaintext["netlify_domain"]}"]
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
