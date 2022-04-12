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
  alarm_name          = "OpenSearch FreeStorageSpace"
  alarm_description   = "OpenSearch FreeStorageSpace"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 3
  unit                = "Megabytes"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/ES"
  metric_name         = "FreeStorageSpace"
  statistic           = "Minimum"

  dimensions = {
    "[sl-logstrg-orange]"     = {
      DomainName: "sl-logstrg-orange-prd"
      ClientId: "468720534852"
    }
  }

  threshold_crit      = 10000
  ok_actions_crit     = true
  alarm_actions_crit  = [dependency.sns_topic_common.outputs.sns_topic_arn]
}