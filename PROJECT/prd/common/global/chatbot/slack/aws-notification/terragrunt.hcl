terraform {
  source = "../../../../../../../SERVICE/chatbot/slack"
}

terraform_version_constraint = ">= 0.13"

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_aws_notification" {
  config_path = "../../../../apne2/sns/alarm-to-slack/aws-notification"
}

dependency "sns_topic_us_aws_notification" {
  config_path = "../../../../usea1/sns/alarm-to-slack/aws-notification"
}

inputs = {
  name                = "slack-aws-notification"
  enabled             = "true"
  org_name            = "knowredev"
  slack_channel_id    = "C0378NH4K3L"
  slack_workspace_id  = "T024UHAGF"
  workspace_name      = "slack-aws-notification"
  alarm_sns_topic_arns = [dependency.sns_topic_aws_notification.outputs.sns_topic_arn, dependency.sns_topic_us_aws_notification.outputs.sns_topic_arn]
}
