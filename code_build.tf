locals {
  codebuild_name        = var.codebuild_name != "" ? var.codebuild_name : var.name
  codebuild_description = var.codebuild_description != "" ? var.codebuild_description : "Codebuild for the ECS Green/Blue ${var.name} app"
}

data "aws_iam_policy_document" "assume_by_codebuild" {
  statement {
    sid     = "AllowAssumeByCodebuild"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "codebuild" {
  name               = "${local.codebuild_name}-codebuild"
  assume_role_policy = data.aws_iam_policy_document.assume_by_codebuild.json
  tags               = var.tags
}

data "aws_iam_policy_document" "codebuild_base" {
  statement {
    sid    = "AllowActions"
    effect = "Allow"

    actions = [
      "ecr:GetAuthorizationToken",
      "secretsmanager:GetSecretValue",
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AllowS3BucketActions"
    effect = "Allow"
    resources = contains(var.allowed_s3_bucket_names, "*") ? ["*"] : [ for bucket in concat([aws_s3_bucket.pipeline.id], var.allowed_s3_bucket_names) : "arn:aws:s3:::${bucket}" ]

    actions = [
      "s3:ListBucket",
    ]
  }

  statement {
    sid    = "AllowS3ObjectActions"
    effect = "Allow"
    resources = contains(var.allowed_s3_bucket_names, "*") ? ["*"] : [ for bucket in concat([aws_s3_bucket.pipeline.id], var.allowed_s3_bucket_names) : "arn:aws:s3:::${bucket}/*" ]

    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:PutObject",
    ]
  }

  statement {
    sid    = "AllowECR"
    effect = "Allow"
    resources = var.ecr_repository_arns

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:BatchImportUpstreamImage",
      "ecr:CompleteLayerUpload",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart",
    ]
  }

  statement {
    sid    = "AllowCloudWatchLogsCreateLogGroupsAndLogStreams"
    effect = "Allow"
    resources = ["arn:aws:logs:*:*:log-group:/aws/codebuild/*"]

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
    ]
  }

  statement {
    sid    = "AllowCloudWatchLogsPutLogEvents"
    effect = "Allow"
    resources = ["arn:aws:logs:*:*:log-group:/aws/codebuild/*:log-stream:*"]

    actions = ["logs:PutLogEvents"]
  }
}

data "aws_iam_policy_document" "codebuild_kms" {
  count       = var.codepipeline_kms_key_arn != null ? 1 : 0
  statement {
    sid       = "AllowKMSActions"
    effect    = "Allow"
    resources = [var.codepipeline_kms_key_arn]

    actions = [
      "kms:DescribeKey",
      "kms:GenerateDataKey",
      "kms:Encrypt",
      "kms:Decrypt",
    ]
  }
}

data "aws_iam_policy_document" "codebuild" {
  source_policy_documents = var.codepipeline_kms_key_arn == null ? [
    data.aws_iam_policy_document.codebuild_base.json
  ] : [
    data.aws_iam_policy_document.codebuild_base.json,
    data.aws_iam_policy_document.codebuild_kms[0].json
  ]
}

resource "aws_iam_role_policy" "codebuild" {
  role   = aws_iam_role.codebuild.name
  policy = data.aws_iam_policy_document.codebuild.json
}

resource "aws_codebuild_project" "this" {
  name         = "${local.codebuild_name}-codebuild"
  description  = local.description
  service_role = aws_iam_role.codebuild.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type    = var.compute_type
    image           = var.codebuild_image
    type            = var.codebuild_type
    privileged_mode = var.privileged_mode

    environment_variable {
      name  = "APP_NAME"
      value = var.APP_NAME
    }

    environment_variable {
      name  = "APP_ENVIRONMENT"
      value = var.APP_ENVIRONMENT
    }

    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = var.IMAGE_REPO_NAME
    }

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = var.aws_account_id
    }

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.region
    }

    environment_variable {
      name  = "IMAGE_TAG"
      value = "latest"
    }

    environment_variable {
      name  = "SERVICE_PORT"
      value = var.SERVICE_PORT
    }

    environment_variable {
      name  = "SHIBBOLETH_SP_BACKEND_AJP_SECRET_ARN"
      value = var.SHIBBOLETH_SP_BACKEND_AJP_SECRET_ARN
    }

    environment_variable {
      name  = "SHIBBOLETH_SP_JSON_CERTS_SECRET_ARN"
      value = var.SHIBBOLETH_SP_JSON_CERTS_SECRET_ARN
    }

    environment_variable {
      name  = "SHIBBOLETH_SP_JSON_CONF_SECRET_ARN"
      value = var.SHIBBOLETH_SP_JSON_CONF_SECRET_ARN
    }

    environment_variable {
      name  = "SHIBBOLETH_SP_SPOOFKEY_SECRET_ARN"
      value = var.SHIBBOLETH_SP_SPOOFKEY_SECRET_ARN
    }

    environment_variable {
      name  = "MEMORY_RESV"
      value = var.MEMORY_RESV
    }

    environment_variable {
      name  = "TASK_CPU"
      value = var.TASK_CPU
    }

    environment_variable {
      name  = "TASK_MEMORY"
      value = var.TASK_MEMORY
    }

    environment_variable {
      name  = "DEPLOY"
      value = var.DEPLOY
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }

#  lifecycle {
#    ignore_changes = [environment]
#  }

  tags = var.tags
}
