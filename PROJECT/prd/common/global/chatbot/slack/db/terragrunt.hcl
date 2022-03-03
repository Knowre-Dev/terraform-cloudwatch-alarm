terraform {
  source = "../../../../../../../SERVICE/chatbot/slack"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_db" {
  config_path = "../../../../apne2/sns/alarm-to-slack/db"
}

dependency "sns_topic_us_db" {
  config_path = "../../../../usea1/sns/alarm-to-slack/db"
}

inputs = {
  name                = "slack-db"
  enabled             = "true"
  org_name            = "knowredev"
  slack_channel_id    = "C03429EM32N"
  slack_workspace_id  = "T024UHAGF"
  workspace_name      = "slack-db"
  alarm_sns_topic_arns = [dependency.sns_topic_db.outputs.sns_topic_arn, dependency.sns_topic_us_db.outputs.sns_topic_arn]
}
