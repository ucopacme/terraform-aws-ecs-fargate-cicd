## EventBridge rule to trigger the pipeline
module "eventbridge" {
  source                 = "git::https://git@github.com/ucopacme/terraform-aws-eventbridge//?ref=v0.0.3"
  pipeline_arn           = aws_codepipeline.this.arn
  create_bus             = false
  create_role            = true
  attach_pipeline_policy = true
  role_name              = "${var.name}-eventbridge"
  trusted_entities       = ["scheduler.amazonaws.com"]
  rules = {
    Eventbridge = {
      description = "Trigger for a codepipeline"
      state = var.cloudwatch_event_rule_state
      event_pattern = jsonencode({ "source" : ["aws.codecommit"], "detail-type" : ["CodeCommit Repository State Change"], "resources" : [var.repository_arn], "detail" : {
      "event" : ["referenceCreated", "referenceUpdated"], "referenceType" : ["branch"], "referenceName" : [var.branchname] } })
    }
  }

  targets = {
    Eventbridge = [
      {
        name                   = "${var.name}-eventbridge"
        arn                    = aws_codepipeline.this.arn
        role_arn               = module.eventbridge.eventbridge_role_arn
        attach_pipeline_policy = true
        attach_role_arn        = true
      }
    ]
  }
  tags = var.tags
}

# The resources below created/used only for cross-account pipelines.
data "aws_iam_policy_document" "cross_account_put_events" {
  count       = length(var.eventbridge_cross_account_ids) != 0 ? 1 : 0
  statement {
    sid       = "AllowCrossAccountPutEvents"
    effect    = "Allow"
    resources = [for account_id in var.eventbridge_cross_account_ids : "arn:aws:events:us-west-2:${account_id}:event-bus/default"]
    actions = ["events:PutEvents"]
  }
}

resource "aws_iam_policy" "cross_account_put_events" {
  count       = length(var.eventbridge_cross_account_ids) != 0 ? 1 : 0
  name        = "${var.name}-eventbridge-cross-account"
  description = "Permissions for ${module.eventbridge.eventbridge_role_name} to put events to other accounts"
  policy      = data.aws_iam_policy_document.cross_account_put_events[0].json
}

resource "aws_iam_role_policy_attachment" "cross_account_put_events" {
  count      = length(var.eventbridge_cross_account_ids) != 0 ? 1 : 0
  role       = module.eventbridge.eventbridge_role_name
  policy_arn = aws_iam_policy.cross_account_put_events[0].arn
}

resource "aws_cloudwatch_event_rule" "cross_account" {
  count       = length(var.eventbridge_cross_account_ids) != 0 ? 1 : 0
  name        = "${var.name}-eventbridge-cross-account"
  description = "Trigger for cross-account codepipeline"
  state       = var.cloudwatch_event_rule_state

  event_pattern = jsonencode({ "source" : ["aws.codecommit"], "detail-type" : ["CodeCommit Repository State Change"], "resources" : [var.repository_arn], "detail" : {
      "event" : ["referenceCreated", "referenceUpdated"], "referenceType" : ["branch"], "referenceName" : [var.cross_account_branchname] } })
  tags = var.tags
}

resource "aws_cloudwatch_event_target" "cross_account_targets" {
  for_each = toset(var.eventbridge_cross_account_ids)
  arn      = "arn:aws:events:us-west-2:${each.key}:event-bus/default"
  rule     = aws_cloudwatch_event_rule.cross_account[0].id
  role_arn = module.eventbridge.eventbridge_role_arn
}
