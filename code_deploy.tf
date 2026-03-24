data "aws_iam_policy_document" "assume_by_codedeploy" {
  count = var.codedeploy ? 1 : 0

  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codedeploy.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "codedeploy" {
  count              = var.codedeploy ? 1 : 0
  name               = "${var.name}-codedeploy"
  assume_role_policy = data.aws_iam_policy_document.assume_by_codedeploy[0].json
  tags               = var.tags
}

data "aws_iam_policy_document" "codedeploy_base" {
  count = var.codedeploy ? 1 : 0

  statement {
    sid    = "AllowAWSCodeDeployForECS"
    effect = "Allow"

    actions = [
      "cloudwatch:DescribeAlarms",
      "ecs:CreateTaskSet",
      "ecs:DeleteTaskSet",
      "ecs:DescribeServices",
      "ecs:TagResource",
      "ecs:UpdateServicePrimaryTaskSet",
      "elasticloadbalancing:DescribeListeners",
      "elasticloadbalancing:DescribeRules",
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:ModifyListener",
      "elasticloadbalancing:ModifyRule",
      "lambda:InvokeFunction",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "sns:Publish",
    ]

    resources = ["*"]
  }

  statement {
    sid     = "AllowPassRole"
    effect  = "Allow"
    actions = ["iam:PassRole"]

    # Initial revision of this module used the execution role for the task role.
    resources = [
      var.task_role == null ? var.execution_role : var.execution_role, var.task_role
    ]
  }
}

data "aws_iam_policy_document" "codedeploy_kms" {
  count = var.codedeploy && var.codepipeline_kms_key_arn != null ? 1 : 0

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

data "aws_iam_policy_document" "codedeploy" {
  count = var.codedeploy ? 1 : 0

  source_policy_documents = var.codepipeline_kms_key_arn == null ? [
    data.aws_iam_policy_document.codedeploy_base[0].json
    ] : [
    data.aws_iam_policy_document.codedeploy_base[0].json,
    data.aws_iam_policy_document.codedeploy_kms[0].json
  ]
}

resource "aws_iam_role_policy" "codedeploy" {
  count  = var.codedeploy ? 1 : 0
  role   = aws_iam_role.codedeploy[0].name
  policy = data.aws_iam_policy_document.codedeploy[0].json
}

resource "aws_codedeploy_app" "this" {
  count            = var.codedeploy ? 1 : 0
  compute_platform = "ECS"
  name             = "${var.name}-service-deploy"
  tags             = var.tags
}

resource "aws_codedeploy_deployment_group" "this" {
  count                  = var.codedeploy ? 1 : 0
  app_name               = aws_codedeploy_app.this[0].name
  deployment_group_name  = "${var.name}-service-deploy-group"
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  service_role_arn       = aws_iam_role.codedeploy[0].arn

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 1
    }
  }

  ecs_service {
    cluster_name = var.cluster_name
    service_name = var.service_name
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = var.listener_arns
      }

      target_group {
        name = var.target_group_0
      }

      target_group {
        name = var.target_group_1
      }
    }
  }

  tags = var.tags
}
