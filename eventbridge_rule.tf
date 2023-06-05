## EventBridge rule to trigger the pipeline 
module "eventbridge" {
  source                 = "git::https://git@github.com/ucopacme/terraform-aws-eventbridge//?ref=v0.0.1"
  pipeline_arn           = aws_codepipeline.this.arn
  create_bus             = false
  create_role            = true
  attach_pipeline_policy = true
  role_name              =  "${var.name}-eventbridge"
  rules = {
    Eventbridge = {
      description = "Trigger for a codepipeline"
      event_pattern = jsonencode({ "source" : ["aws.codecommit"], "detail-type" : ["CodeCommit Repository State Change"], "resources" : [var.repository_arn], "detail" : {
      "event" : ["referenceCreated", "referenceUpdated"], "referenceType" : ["branch"], "referenceName" : ["master"] } })
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
