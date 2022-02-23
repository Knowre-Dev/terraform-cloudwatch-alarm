terraform {
  source = "../../../../../../../SERVICE/cloudwatch/event/event-bridge"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic" {
  config_path = "../../../sns/alarm-to-slack/common"
}

inputs = {
  name      = "aws-ecs-events"
  role      = "mgt"
  event_pattern = <<PATTERN
{
  "detail-type": [
    "ECS Task State Change",
    "ECS Service Action",
    "ECS Deployment State Change"
  ],
  "source": [
    "aws.ecs"
  ]
}
PATTERN

  sns_topic = dependency.sns_topic.outputs.sns_topic_arn
  enabled   = true
}