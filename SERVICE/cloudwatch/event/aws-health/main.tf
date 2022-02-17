provider "aws" {
  region = var.aws_region
}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}
}

# resource "aws_lambda_permission" "cloudwatch_trigger" {
#   statement_id  = "AllowExecutionFromCloudWatch"
#   action        = "lambda:InvokeFunction"
#   function_name = data.terraform_remote_state.lambda_function.outputs.lambda_function_name
#   principal     = "events.amazonaws.com"
#   source_arn    = aws_cloudwatch_event_rule.cloudwatch_event_rule[0].arn

#   count         = length(var.schedule_expression) > 0 ? 1 : 0
# }

module "cloudwatch_event_rule_label" {
  source      = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.24.1"
  enabled     = var.enabled
  namespace   = var.namespace
  environment = var.environment
  stage       = var.stage
  name        = var.name
  attributes  = ["cloudwatch", "event", "rule"]
  tags        = map("Service", var.name)
}

resource "aws_cloudwatch_event_rule" "cloudwatch_event_rule" {
  name        = module.cloudwatch_event_rule_label.id
  # name = "aws-health-events"
  description = "A CloudWatch Event Rule that triggers on changes in the status of AWS Personal Health Dashboard (AWS Health) and forwards the events to an SNS topic."
  is_enabled  = true

  event_pattern = <<PATTERN
{
  "detail-type": [
    "AWS Health Event"
  ],
  "source": [
    "aws.health"
  ]
}
PATTERN

}

resource "aws_cloudwatch_event_target" "cloudwatch_event_target" {
  target_id = var.name
  rule      = aws_cloudwatch_event_rule.cloudwatch_event_rule.name
  arn       = var.sns_topic
}
