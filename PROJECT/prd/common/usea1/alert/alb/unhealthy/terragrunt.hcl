terraform {
  source = "../../../../../../../SERVICE/cloudwatch/metric/alarm/generic_multiple_dimension"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_common" {
  config_path         = "../../../sns/alarm-to-slack/common"
}

inputs = {
  alarm_name          = "Unhealthy Host Count"
  alarm_description   = "Unhealthy Host Count"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 3
  unit                = "Count"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/ApplicationELB"
  metric_name         = "UnHealthyHostCount"
  statistic           = "Maximum"

  # dimensions = var.dimensions
  dimensions = {
    "[glacl-us-stable]" = {
      TargetGroup = "targetgroup/glacl-us-stable/5bd34c9f49cb8bf2"
      LoadBalancer = "app/glacl-us-stable/dd65a729d972f43d"
    },
    "[locian0us-usp-stable]" = {
      TargetGroup = "targetgroup/locian0us-usp-stable/5ec0cd24fa791534"
      LoadBalancer = "app/locian0us-usp-stable/b93815483f33da5d"
    },
    "[mowbore-nv-stable]" = {
      TargetGroup = "targetgroup/mowbore-nv-stable/6f80c1dd9c3dd186"
      LoadBalancer = "app/mowbore-nv-stable/cffacdb29e10b625"
    }
  }

  enable_crit              = true
  threshold_crit           = 1
  ok_actions_crit          = true
  alarm_actions_crit       = [dependency.sns_topic_common.outputs.sns_topic_arn]
  # extended_statistic = var.extended_statistic
}

