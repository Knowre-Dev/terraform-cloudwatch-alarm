terraform {
  source = "../../../../../../../SERVICE/cloudwatch/event/aws-health"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic" {
  config_path = "../../../sns/alarm-to-slack/common"
}

inputs = {
  name      = "aws-health-events"
  role      = "mgt"
  sns_topic = dependency.sns_topic.outputs.sns_topic_arn
  enabled   = true
}