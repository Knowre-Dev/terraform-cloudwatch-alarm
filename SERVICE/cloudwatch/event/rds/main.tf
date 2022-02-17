provider "aws" {
  region = var.aws_region
}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}
}

resource "aws_db_event_subscription" "default" {
  enabled           = var.enabled
  name              = var.name
  name_prefix       = var.name_prefix

  sns_topic         = var.sns_topic
  source_ids        = var.source_ids
  source_type       = var.source_type

  event_categories  = var.event_categories
  tags              = var.tags
}