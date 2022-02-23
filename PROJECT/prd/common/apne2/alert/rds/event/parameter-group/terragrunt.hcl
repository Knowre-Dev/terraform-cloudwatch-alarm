terraform {
  source = "../../../../../../../../SERVICE/cloudwatch/event/rds"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_db" {
  config_path = "../../../../sns/alarm-to-slack/db"
}

inputs = {
  name      = "rds-parameter-group-events"
  role      = "mgt"
  # name_prefix      = ""

  sns_topic = dependency.sns_topic_db.outputs.sns_topic_arn

  source_type = "db-parameter-group"

  event_categories = [
    "configuration change"
  ] 

  enabled = true
}