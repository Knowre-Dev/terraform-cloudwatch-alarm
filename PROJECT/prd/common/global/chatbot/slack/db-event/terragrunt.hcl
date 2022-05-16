terraform {
  source = "../../../../../../../SERVICE/chatbot/slack"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_db" {
  config_path = "../../../../apne2/sns/alarm-to-slack/db-event"
}

dependency "sns_topic_us_db" {
  config_path = "../../../../usea1/sns/alarm-to-slack/db-event"
}

inputs = {
  name                = "slack-db-event"
  enabled             = "true"
  org_name            = "knowredev"
  slack_channel_id    = "C03FMNPAQMS"
  slack_workspace_id  = "T024UHAGF"
  workspace_name      = "slack-db-event"
  alarm_sns_topic_arns = [dependency.sns_topic_db.outputs.sns_topic_arn, dependency.sns_topic_us_db.outputs.sns_topic_arn]
}
