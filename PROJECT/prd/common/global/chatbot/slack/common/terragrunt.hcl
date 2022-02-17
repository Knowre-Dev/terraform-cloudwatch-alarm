terraform {
  source = "../../../../../../../SERVICE/chatbot/slack"
}

terraform_version_constraint = ">= 0.13"

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_common" {
  config_path = "../../../../apne2/sns/alarm-to-slack/common"
}

inputs = {
  name = "slack-common"
  enabled = "true"
  org_name = "knowredev"
  slack_channel_id = "C02V18DDRFH"
  slack_workspace_id = "T024UHAGF"
  workspace_name = "slack-common"
  alarm_sns_topic_arns = [dependency.sns_topic_common.outputs.sns_topic_arn]
}
