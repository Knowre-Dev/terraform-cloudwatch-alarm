terraform {
  source = "../../../../../../../SERVICE/chatbot/slack"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_db" {
  config_path = "../../../../apne2/sns/alarm-to-slack/ecs-event"
}

dependency "sns_topic_us_db" {
  config_path = "../../../../usea1/sns/alarm-to-slack/ecs-event"
}

inputs = {
  name                = "slack-ecs-event"
  enabled             = "true"
  org_name            = "knowredev"
  slack_channel_id    = "C03FKBTQHFU"
  slack_workspace_id  = "T024UHAGF"
  workspace_name      = "slack-ecs-event"
  alarm_sns_topic_arns = [dependency.sns_topic_db.outputs.sns_topic_arn, dependency.sns_topic_us_db.outputs.sns_topic_arn]
}
