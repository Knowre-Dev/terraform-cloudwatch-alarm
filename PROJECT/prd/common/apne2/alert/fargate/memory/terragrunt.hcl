terraform {
  source = "../../../../../../../../SERVICE/terraform-service-aws-cloudwatch-alert/cloudwatch/metric/alarm/generic_multiple_dimension"
}

terraform_version_constraint = ">= 0.12"

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_common" {
  config_path = "../../../sns/alarm-to-slack/common"
}

inputs = {
  alarm_name          = "[KR] Fargate Memory Usage"
  alarm_description   = "[KR] Fargate Memory Usage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 3
  unit                = "Percent"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/ECS"
  metric_name         = "MemoryUtilization"
  statistic           = "Maximum"

  dimensions = {
    "-alarm-test"     = {
      ClusterName: "alarm-test"
      ServiceName: "alarm-test"
    },
  }

  threshold_warn      = 70
  threshold_crit      = 90
  ok_actions          = true
  alarm_actions       = [dependency.sns_topic_common.outputs.sns_topic_arn]
}