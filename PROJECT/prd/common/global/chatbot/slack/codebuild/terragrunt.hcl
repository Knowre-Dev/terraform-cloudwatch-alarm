terraform {
  source = "git::ssh://git@github.com/Knowre-Dev/terraform-service-repo.git//chatbot/slack?ref=main"
}

terraform_version_constraint = ">= 0.13"

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_codebuild" {
  config_path = "../../../../apne2/sns/alarm-to-slack/codebuild"
}

inputs = {
  name                = "slack-codebuild"
  application         = "mgmt-infra"
  enabled             = "true"
  org_name            = "knowredev"
  slack_channel_id    = "C08FYUKMFD5"
  slack_workspace_id  = "T024UHAGF"
  workspace_name      = "slack-codebuild"
  alarm_sns_topic_arns = [dependency.sns_topic_codebuild.outputs.sns_topic_arn]
}
