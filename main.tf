data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [var.openid_connect_provider_arn]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.organisation}/${var.repo}:*"]
    }
    effect = "Allow"
  }
}

resource "aws_iam_role" "this" {
  name               = var.repo
  description        = "Role to permit GitHub action to assume other roles"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  tags               = var.tags
}

data "aws_iam_policy_document" "allow_ecr_policy" {

statement {
    actions = [
      "ecr:GetAuthorizationToken"
    ]

    resources = ["*"]
    effect    = "Allow"
  }

  statement {
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:GetAuthorizationToken"
    ]

    resources = ["arn:aws:ecr:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:repository/${var.repo}"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "allow_ecr_policy" {
  name        = "AllowECR${var.repo}"
  description = "Permit ECR operations for ${var.repo}"
  policy      = data.aws_iam_policy_document.allow_ecr_policy.json
  tags        = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.allow_ecr_policy.arn
}
