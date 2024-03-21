terraform {
  source = "../../../../../../../SERVICE/chatbot/slack"
  # source = "git::ssh://git@github.com/Knowre-Dev/terraform-service-repo.git//chatbot/slack?ref=main"
}

terraform_version_constraint = ">= 0.13"

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_score" {
  config_path = "../../../../apne2/sns/alertnow/summit-score/topic"
}

dependency "sns_topic_hexagon" {
  config_path = "../../../../apne2/sns/alertnow/step-english/topic"
}


inputs = {
  name                = "slack-alertnow"
  enabled             = "true"
  org_name            = "knowredev"
  slack_channel_id    = "C06QHRPBCKF"
  slack_workspace_id  = "T024UHAGF"
  workspace_name      = "slack-alertnow"
  alarm_sns_topic_arns = [dependency.sns_topic_score.outputs.sns_topic_arn, dependency.sns_topic_hexagon.outputs.sns_topic_arn]
}
