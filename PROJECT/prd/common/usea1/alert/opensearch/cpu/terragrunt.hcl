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
  alarm_name          = "OpenSearch CPU Usage"
  alarm_description   = "OpenSearch CPU Usage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 3
  unit                = "Percent"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/ES"
  metric_name         = "CPUUtilization"
  statistic           = "Average"

  dimensions = {
    "[nv-logstrg-orange-prd]"     = {
      DomainName: "nv-logstrg-orange-prd"
      ClientId: "468720534852"
    }
  }

  threshold_warn           = 70
  ok_actions_warn          = true
  alarm_actions_warn       = [dependency.sns_topic_mgt.outputs.sns_topic_arn]

  threshold_crit           = 90
  ok_actions_crit          = false
  alarm_actions_crit       = [dependency.sns_topic_mgt.outputs.sns_topic_arn]
}