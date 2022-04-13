terraform {
  source = "../../../../../../../SERVICE/chatbot/slack"
}

terraform_version_constraint = ">= 0.13"

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_server" {
  config_path = "../../../../apne2/sns/alarm-to-slack/server"
}

dependency "sns_topic_us_server" {
  config_path = "../../../../usea1/sns/alarm-to-slack/server"
}

inputs = {
  name                = "slack-server"
  enabled             = "true"
  org_name            = "knowredev"
  slack_channel_id    = "C03BN18ASKT"
  slack_workspace_id  = "T024UHAGF"
  workspace_name      = "slack-server"
  alarm_sns_topic_arns = [dependency.sns_topic_server.outputs.sns_topic_arn, dependency.sns_topic_us_server.outputs.sns_topic_arn]
}
