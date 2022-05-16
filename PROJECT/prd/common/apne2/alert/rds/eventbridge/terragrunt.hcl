terraform {
  source = "../../../../../../../SERVICE/cloudwatch/event/event-bridge"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic" {
  config_path = "../../../../apne2/sns/alarm-to-slack/db-event"
}

inputs = {
  name      = "aws-rds-events"
  role      = "mgt"
  event_pattern = <<PATTERN
{
  "source": [
    "aws.rds"
  ]
}
PATTERN

  sns_topic = dependency.sns_topic.outputs.sns_topic_arn
  enabled   = true
}