
data "aws_iam_policy_document" "ghost_app_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      identifiers = ["*"]
    }
  }
}
resource "aws_iam_role" "ghost_role" {
  name               = "ghost_app"
  assume_role_policy = data.aws_iam_policy_document.ghost_app_assume_role_policy.json
  managed_policy_arns = [aws_iam_policy.ghost_policy.arn]
}
resource "aws_iam_policy" "ghost_policy" {
  name = "ghost_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "ssm:GetParameter*",
          "secretsmanager:GetSecretValue",
          "kms:Decrypt",
          "elasticfilesystem:DescribeFileSystems",
          "elasticfilesystem:ClientMount",
          "elasticfilesystem:ClientWrite",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
/*
#====================================
resource "aws_iam_policy" "policy_aws" {
  name        = "aws_policy"
  path        = "/"
  description = "aws policy"
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "ssm:GetParameter*",
          "secretsmanager:GetSecretValue",
          "kms:Decrypt",
          "elasticfilesystem:DescribeFileSystems",
          "elasticfilesystem:ClientMount",
          "elasticfilesystem:ClientWrite",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role" "ghost_app_role" {
  name                = "ghost_app"
  managed_policy_arns = [aws_iam_policy.policy_aws.arn]
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          AWS = "*"
        }
      },
    ]
  })
  tags = {
    tag-key = "ghost_app"
  }
}

/*
resource "aws_iam_policy" "policy_aws" {
  name        = "aws_policy"
  path        = "/"
  description = "aws policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
            "ec2:Describe*",
            "ecr:GetAuthorizationToken",
            "ecr:BatchCheckLayerAvailability",
            "ecr:GetDownloadUrlForLayer",
            "ecr:BatchGetImage",
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "ssm:GetParameter*",
            "secretsmanager:GetSecretValue",
            "kms:Decrypt",
            "elasticfilesystem:DescribeFileSystems",
            "elasticfilesystem:ClientMount",
            "elasticfilesystem:ClientWrite",
    ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role" "ghost_app_role" {
  name = "ghost_app"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = [
            "ec2.amazonaws.com",
# error     "ecr.amazonaws.com",
            "logs.amazonaws.com", 
            "ssm-incidents.amazonaws.com", 
            "ssm.amazonaws.com",
            "secretsmanager.amazonaws.com",
            "kms.amazonaws.com",
            "elasticfilesystem.amazonaws.com",
            "iam.amazonaws.com"
           ]
        }
      },
    ]
  })

  tags = {
    tag-key = "ghost_app"
  }
}
/*
data "aws_iam_policy_document" "ghost_app_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      identifiers = ["*"]
    }
  }
}
resource "aws_iam_role" "ghost_role" {
  name               = "ghost_app"
  assume_role_policy = data.aws_iam_policy_document.ghost_app_assume_role_policy.json
  managed_policy_arns = [aws_iam_policy.ghost_policy.arn]
}
resource "aws_iam_policy" "ghost_policy" {
  name = "ghost_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = var.iam_policy
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
*/