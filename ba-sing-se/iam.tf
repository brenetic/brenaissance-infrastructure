resource "aws_iam_user" "ba-sing-se-deployer" {
  name = "${local.service}-deployer"
}

resource "aws_iam_user_policy" "deployer_user_policy" {
  name = "${local.service}-deployer-policy"
  user = "${aws_iam_user.ba-sing-se-deployer.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "apigateway:*",
        "cloudformation:*",
        "dynamodb:*",
        "events:*",
        "iam:*",
        "lambda:*",
        "logs:*",
        "route53:*",
        "s3:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}
