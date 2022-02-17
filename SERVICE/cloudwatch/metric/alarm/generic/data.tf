data "terraform_remote_state" "sns_topic_arn" {
  backend = "s3"

  config = {
    bucket         = var.bucket
    key            = var.default_sns_topic_arn_remote_state_key
    region         = var.config_region
    encrypt        = true
    dynamodb_table = var.dynamodb_table
    acl            = "bucket-owner-full-control"
  }
}