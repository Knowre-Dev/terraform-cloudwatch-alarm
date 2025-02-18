terraform {
  source = "../../../../../../../SERVICE/cloudwatch/metric/alarm/generic_multiple_dimension"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_mgt" {
  config_path = "../../../sns/alarm-to-slack/mgt"
}

inputs = {
  alarm_name          = "OpenSearch JVMMemoryPressure"
  alarm_description   = "OpenSearch JVMMemoryPressure"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 5
  unit                = "Percent"
  period              = 60
  datapoints_to_alarm = 3

  cw_namespace        = "AWS/ES"
  metric_name         = "JVMMemoryPressure"
  statistic           = "Maximum"

  dimensions = {
    "[sl-logstrg-orange]"     = {
      DomainName: "sl-logstrg-orange-prd"
      ClientId: "468720534852"
    }
  }

  threshold_crit           = 80
  ok_actions_crit          = true
  alarm_actions_crit       = [dependency.sns_topic_mgt.outputs.sns_topic_arn]
  # extended_statistic = var.extended_statistic
}