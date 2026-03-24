## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eventbridge"></a> [eventbridge](#module\_eventbridge) | git::https://git@github.com/ucopacme/terraform-aws-eventbridge// | v0.0.3 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.cross_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.cross_account_targets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_codebuild_project.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codedeploy_app.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codedeploy_app) | resource |
| [aws_codedeploy_deployment_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codedeploy_deployment_group) | resource |
| [aws_codepipeline.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline) | resource |
| [aws_iam_policy.cross_account_put_events](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.codedeploy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.codedeploy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.cross_account_put_events](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_s3_bucket.pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_scheduler_schedule.pipeline_schedule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/scheduler_schedule) | resource |
| [aws_iam_policy_document.assume_by_codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume_by_codedeploy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume_by_pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codebuild_base](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codebuild_kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codedeploy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codedeploy_base](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.codedeploy_kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cross_account_put_events](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.pipeline_base](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.pipeline_bucket_base](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.pipeline_bucket_cross_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.pipeline_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.pipeline_cross_account_role_assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.pipeline_kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_APACHESHIB_HOST"></a> [APACHESHIB\_HOST](#input\_APACHESHIB\_HOST) | Environment variable for consumption in CodeBuild | `string` | `""` | no |
| <a name="input_APP_ENVIRONMENT"></a> [APP\_ENVIRONMENT](#input\_APP\_ENVIRONMENT) | Environment variable for consumption in CodeBuild (usually set to ucop:environment tag) | `string` | `""` | no |
| <a name="input_APP_NAME"></a> [APP\_NAME](#input\_APP\_NAME) | Environment variable for consumption in CodeBuild (usually set to ucop:application tag) | `string` | `""` | no |
| <a name="input_DEPLOY"></a> [DEPLOY](#input\_DEPLOY) | The resource name. | `string` | `""` | no |
| <a name="input_EXTRA_ENV_VARS"></a> [EXTRA\_ENV\_VARS](#input\_EXTRA\_ENV\_VARS) | Additional environment variables to pass to CodeBuild | `map(string)` | `{}` | no |
| <a name="input_IMAGE_REPO_NAME"></a> [IMAGE\_REPO\_NAME](#input\_IMAGE\_REPO\_NAME) | The resource name. | `string` | `null` | no |
| <a name="input_MEMORY_RESV"></a> [MEMORY\_RESV](#input\_MEMORY\_RESV) | The resource name. | `string` | `null` | no |
| <a name="input_SERVICE_PORT"></a> [SERVICE\_PORT](#input\_SERVICE\_PORT) | The resource name. | `string` | `null` | no |
| <a name="input_SHIBBOLETH_SP_BACKEND_AJP_SECRET_ARN"></a> [SHIBBOLETH\_SP\_BACKEND\_AJP\_SECRET\_ARN](#input\_SHIBBOLETH\_SP\_BACKEND\_AJP\_SECRET\_ARN) | Environment variable for consumption in CodeBuild | `string` | `""` | no |
| <a name="input_SHIBBOLETH_SP_JSON_CERTS_SECRET_ARN"></a> [SHIBBOLETH\_SP\_JSON\_CERTS\_SECRET\_ARN](#input\_SHIBBOLETH\_SP\_JSON\_CERTS\_SECRET\_ARN) | Environment variable for consumption in CodeBuild | `string` | `""` | no |
| <a name="input_SHIBBOLETH_SP_JSON_CONF_SECRET_ARN"></a> [SHIBBOLETH\_SP\_JSON\_CONF\_SECRET\_ARN](#input\_SHIBBOLETH\_SP\_JSON\_CONF\_SECRET\_ARN) | Environment variable for consumption in CodeBuild | `string` | `""` | no |
| <a name="input_SHIBBOLETH_SP_SPOOFKEY_SECRET_ARN"></a> [SHIBBOLETH\_SP\_SPOOFKEY\_SECRET\_ARN](#input\_SHIBBOLETH\_SP\_SPOOFKEY\_SECRET\_ARN) | Environment variable for consumption in CodeBuild | `string` | `""` | no |
| <a name="input_TASK_CPU"></a> [TASK\_CPU](#input\_TASK\_CPU) | Environment variable for consumption in CodeBuild | `string` | `""` | no |
| <a name="input_TASK_MEMORY"></a> [TASK\_MEMORY](#input\_TASK\_MEMORY) | Environment variable for consumption in CodeBuild | `string` | `""` | no |
| <a name="input_allowed_s3_bucket_names"></a> [allowed\_s3\_bucket\_names](#input\_allowed\_s3\_bucket\_names) | S3 buckets for which access will be granted in IAM policies | `list(string)` | <pre>[<br/>  "*"<br/>]</pre> | no |
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | n/a | `string` | `""` | no |
| <a name="input_branchname"></a> [branchname](#input\_branchname) | The resource name. | `string` | `null` | no |
| <a name="input_cloudwatch_event_rule_state"></a> [cloudwatch\_event\_rule\_state](#input\_cloudwatch\_event\_rule\_state) | State of event rules that trigger CodePipline. Set to DISABLED if commits should not trigger the pipeline. | `string` | `"ENABLED"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The resource name. | `string` | `null` | no |
| <a name="input_codebuild_description"></a> [codebuild\_description](#input\_codebuild\_description) | (Optional) description for CodeBuild project | `string` | `""` | no |
| <a name="input_codebuild_image"></a> [codebuild\_image](#input\_codebuild\_image) | The resource name. | `string` | `"aws/codebuild/amazonlinux2-x86_64-standard:4.0"` | no |
| <a name="input_codebuild_name"></a> [codebuild\_name](#input\_codebuild\_name) | (Optional) custom name for CodeBuild project | `string` | `""` | no |
| <a name="input_codebuild_type"></a> [codebuild\_type](#input\_codebuild\_type) | The resource name. | `string` | `"LINUX_CONTAINER"` | no |
| <a name="input_codedeploy"></a> [codedeploy](#input\_codedeploy) | Whether to create CodeDeploy resources and the Deploy stage in the pipeline. Set to false for build-only pipelines. | `bool` | `true` | no |
| <a name="input_codepipeline_bucket_name"></a> [codepipeline\_bucket\_name](#input\_codepipeline\_bucket\_name) | Custom S3 bucket name for CodePipeline artifact store | `string` | `""` | no |
| <a name="input_codepipeline_cross_account_ids"></a> [codepipeline\_cross\_account\_ids](#input\_codepipeline\_cross\_account\_ids) | (Optional) account IDs that will be granted access to codepipeline bucket | `list(string)` | `[]` | no |
| <a name="input_codepipeline_cross_account_role_arn"></a> [codepipeline\_cross\_account\_role\_arn](#input\_codepipeline\_cross\_account\_role\_arn) | (Optional) role ARN that CodePipeline service role will be granted access to assume | `string` | `null` | no |
| <a name="input_codepipeline_kms_key_arn"></a> [codepipeline\_kms\_key\_arn](#input\_codepipeline\_kms\_key\_arn) | (Optional) ARN of KMS key used to encrypt CodePipeline artifacts uploaded to S3 | `string` | `null` | no |
| <a name="input_codepipeline_name"></a> [codepipeline\_name](#input\_codepipeline\_name) | (Optional) custom name for pipeline | `string` | `""` | no |
| <a name="input_compute_type"></a> [compute\_type](#input\_compute\_type) | The resource name. | `string` | `"BUILD_GENERAL1_SMALL"` | no |
| <a name="input_cross_account_branchname"></a> [cross\_account\_branchname](#input\_cross\_account\_branchname) | The resource name. | `string` | `null` | no |
| <a name="input_ecr_repository_arns"></a> [ecr\_repository\_arns](#input\_ecr\_repository\_arns) | ECR repository ARNs | `list(string)` | <pre>[<br/>  "*"<br/>]</pre> | no |
| <a name="input_eventbridge_cross_account_ids"></a> [eventbridge\_cross\_account\_ids](#input\_eventbridge\_cross\_account\_ids) | (Optional) account IDs we allow our eventbridge role to PutEvents to (for triggering cross account pipeline execution) | `list(string)` | `[]` | no |
| <a name="input_execution_role"></a> [execution\_role](#input\_execution\_role) | The resource name. | `string` | `null` | no |
| <a name="input_listener_arns"></a> [listener\_arns](#input\_listener\_arns) | The resource name. | `list(string)` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"cluster"` | no |
| <a name="input_pipeline_schedule_expression"></a> [pipeline\_schedule\_expression](#input\_pipeline\_schedule\_expression) | (Optional) schedule expression for automatically triggering pipeline | `string` | `null` | no |
| <a name="input_pipeline_schedule_expression_timezone"></a> [pipeline\_schedule\_expression\_timezone](#input\_pipeline\_schedule\_expression\_timezone) | (Optional) timezone associated with pipeline\_schedule\_expression | `string` | `"US/Pacific"` | no |
| <a name="input_pipeline_schedule_maximum_window_in_minutes"></a> [pipeline\_schedule\_maximum\_window\_in\_minutes](#input\_pipeline\_schedule\_maximum\_window\_in\_minutes) | (Optional) maximum time window during which a schedule can be invoked | `string` | `null` | no |
| <a name="input_privileged_mode"></a> [privileged\_mode](#input\_privileged\_mode) | Set to `false` to prevent Database accessibility | `bool` | `true` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"us-west-2"` | no |
| <a name="input_repository_arn"></a> [repository\_arn](#input\_repository\_arn) | The repo arn. | `string` | `null` | no |
| <a name="input_repositoryname"></a> [repositoryname](#input\_repositoryname) | The resource name. | `string` | `null` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | The resource name. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_target_group_0"></a> [target\_group\_0](#input\_target\_group\_0) | The resource name. | `string` | `null` | no |
| <a name="input_target_group_1"></a> [target\_group\_1](#input\_target\_group\_1) | The resource name. | `string` | `null` | no |
| <a name="input_task_role"></a> [task\_role](#input\_task\_role) | The resource name. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_codepipeline_arn"></a> [codepipeline\_arn](#output\_codepipeline\_arn) | CodePipeline ARN |
