terraform {
  source = "../../../../../../../SERVICE/cloudwatch/metric/alarm/generic_multiple_dimension"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_common" {
  config_path = "../../../sns/alarm-to-slack/common"
}

inputs = {
  alarm_name          = "OpenSearch Master JVMMemoryPressure"
  alarm_description   = "OpenSearch Master JVMMemoryPressure"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 3
  unit                = "Percent"
  period              = 300
  datapoints_to_alarm = 3

  cw_namespace        = "AWS/ES"
  metric_name         = "MasterJVMMemoryPressure"
  statistic           = "Maximum"

  dimensions = {
    "[nv-logstrg-orange-prd]"     = {
      DomainName: "nv-logstrg-orange-prd"
      ClientId: "468720534852"
    }
  }

  threshold_crit           = 80
  ok_actions_crit          = true
  alarm_actions_crit       = [dependency.sns_topic_common.outputs.sns_topic_arn]
  # extended_statistic = var.extended_statistic
}