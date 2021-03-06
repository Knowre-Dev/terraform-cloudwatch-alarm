terraform {
  source = "../../../../../../../SERVICE/cloudwatch/event/event-bridge"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic" {
  config_path = "../../../../apne2/sns/alarm-to-slack/ecs-event"
}

inputs = {
  name      = "aws-ecs-events"
  role      = "mgt"
  event_pattern = <<PATTERN
{
  "source": [
    "aws.ecs"
  ],
  "detail-type": ["ECS Container Instance State Change", "ECS Service Action"]
}
PATTERN

  sns_topic = dependency.sns_topic.outputs.sns_topic_arn
  enabled   = true
}