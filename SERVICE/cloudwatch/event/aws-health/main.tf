provider "aws" {
  region = var.aws_region
}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}
}

module "cloudwatch_event_rule_label" {
  source          = "cloudposse/label/null"
  version         = "0.25.0"
  enabled         = var.enabled
  stage           = var.env
  environment     = var.region_code
  namespace       = var.country
  tenant          = var.role
  name            = var.name
  attributes      = ["cloudwatch", "event", "rule"]

  label_order     = ["stage", "environment", "namespace", "name", "attributes"]
  labels_as_tags  = []
  tags            = {
    "env"         = "${var.env}"
    "region"      = "${var.aws_region}"
    "region_code" = "${var.region_code}"
    "country"     = "${var.country}"
    "role"        = "${var.role}"
    "service"     = "${var.name}"
  }
}

resource "aws_cloudwatch_event_rule" "cloudwatch_event_rule" {
  name        = module.cloudwatch_event_rule_label.id
  # name = "aws-health-events"
  description = "A CloudWatch Event Rule that triggers on changes in the status of AWS Personal Health Dashboard (AWS Health) and forwards the events to an SNS topic."
  is_enabled  = true

  event_pattern = <<PATTERN
{
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
