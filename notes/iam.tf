resource "aws_iam_user" "notes-deployer" {
  name = "${local.service}-deployer"
}

resource "aws_iam_user_policy" "deployer_user_policy" {
  name   = "${local.service}-deployer-policy"
  user   = "${aws_iam_user.notes-deployer.name}"
  policy = "${data.aws_iam_policy_document.deployer_user_policy_document.json}"
}

data "aws_iam_policy_document" "deployer_user_policy_document" {
  statement {
    actions   = ["cloudformation:*"]
    resources = [
      "arn:aws:cloudformation:${local.region}:${local.account}:stack/${local.service}*/*"
    ]
  }

  statement {
    actions   = ["cloudformation:ValidateTemplate"]
    resources = ["*"]
  }

  statement {
    actions = [
      "s3:CreateBucket",
      "s3:DeleteBucket",
      "s3:Get*",
      "s3:List*"
    ]

    resources = ["arn:aws:s3:::*"]
  }

  statement {
    actions   = ["s3:*"]
    resources = ["arn:aws:s3:::*/*"]
  }

  statement {
    actions   = ["logs:DescribeLogGroups"]
    resources = [
      "arn:aws:logs:${local.region}:${local.account}:log-group::log-stream:*"
    ]
  }

  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DeleteLogGroup",
      "logs:DeleteLogStream",
      "logs:DescribeLogStreams",
      "logs:FilterLogEvents"
    ]

    resources = [
      "arn:aws:logs:${local.region}:${local.account}:log-group:/aws/lambda/${local.service}*:log-stream:*"
    ]
  }

  statement {
    actions = [
      "iam:GetRole",
      "iam:PassRole",
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:DetachRolePolicy",
      "iam:PutRolePolicy",
      "iam:AttachRolePolicy",
      "iam:DeleteRolePolicy"
    ]

    resources = ["arn:aws:iam::${local.account}:role/${local.service}*-lambdaRole"]
  }

  statement {
    actions = [
      "apigateway:GET",
      "apigateway:POST",
      "apigateway:PUT",
      "apigateway:DELETE"
    ]

    resources = ["arn:aws:apigateway:${local.region}::/restapis"]
  }

  statement {
    actions = [
      "lambda:GetFunction",
      "lambda:CreateFunction",
      "lambda:DeleteFunction",
      "lambda:UpdateFunctionConfiguration",
      "lambda:UpdateFunctionCode",
      "lambda:ListVersionsByFunction",
      "lambda:PublishVersion",
      "lambda:CreateAlias",
      "lambda:DeleteAlias",
      "lambda:UpdateAlias",
      "lambda:GetFunctionConfiguration",
      "lambda:AddPermission",
      "lambda:RemovePermission",
      "lambda:InvokeFunction"
    ]

    resources = ["arn:aws:lambda:*:${local.account}:function:${local.service}*"]
  }

  statement {
    actions = [
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeVpcs"
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "events:Put*",
      "events:Remove*",
      "events:Delete*",
      "events:Describe*"
    ]

    resources = ["arn:aws:events::${local.account}:rule/${local.service}*"]
  }
}
