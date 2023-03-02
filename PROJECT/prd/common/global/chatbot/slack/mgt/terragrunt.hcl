terraform {
  source = "../../../../../../../SERVICE/chatbot/slack"
}

terraform_version_constraint = ">= 0.13"

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_mgt" {
  config_path = "../../../../apne2/sns/alarm-to-slack/mgt"
}

# dependency "sns_topic_us_mgt" {
#   config_path = "../../../../usea1/sns/alarm-to-slack/mgt"
# }

inputs = {
  name                = "slack-mgt"
  enabled             = "true"
  org_name            = "knowredev"
  slack_channel_id    = "C04RJBN5MN3"
  slack_workspace_id  = "T024UHAGF"
  workspace_name      = "slack-mgt"
  alarm_sns_topic_arns = [dependency.sns_topic_mgt.outputs.sns_topic_arn]
  # alarm_sns_topic_arns = [dependency.sns_topic_mgt.outputs.sns_topic_arn, dependency.sns_topic_us_mgt.outputs.sns_topic_arn]
}
