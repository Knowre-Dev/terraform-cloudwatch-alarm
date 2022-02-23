terraform {
  source = "../../../../../../../SERVICE/cloudwatch/metric/alarm/generic_all_dimension"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_common" {
  config_path         = "../../../sns/alarm-to-slack/common"
}

inputs = {
  alarm_name          = "5XX Error Count"
  alarm_description   = "5XX Error Count"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  unit                = "Count"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/ApplicationELB"
  metric_name         = "HTTPCode_Target_5XX_Count"
  statistic           = "Sum"

  # dimensions = var.dimensions
  dimensions = {
    "[dky]" = {
      TargetGroup = "targetgroup/dky-stable/f06948eaf912b016"
      LoadBalancer = "app/dky-stable/2fbfb438da5302a7"
    },
    "[locaian0kr]" = {
      TargetGroup = "targetgroup/locian0kr-stable/504508a93e46900d"
      LoadBalancer = "app/locian0kr-stable/5118b11b02a7dad9"
    },
    "[glacl-kr]" = {
      TargetGroup = "targetgroup/glacl-kr-stable/ff22215517c24e4b"
      LoadBalancer = "app/glacl-kr-stable/df4550d6e9e8bfdf"
    },
    "[krsqr]" = {
      TargetGroup = "targetgroup/krsqr-stable/49f44fee75da1603"
      LoadBalancer = "app/krsqr-stable/17b1563bfe7f7b1a"
    },
    "[mowbore-sl]" = {
      TargetGroup = "targetgroup/mowbore-sl-stable/3ea9d3b70880981f"
      LoadBalancer = "app/mowbore-sl-stable/875688c2a52379f9"
    }
    "[mowbore-dump-worker]" = {
      TargetGroup = "targetgroup/mowbore-dump-worker-stable/a27787cb7b914f6b"
      LoadBalancer = "app/mowbore-dump-worker-stable/b3f70a9a8b338b19"
    },
    "[knowre-school-lms]" = {
      TargetGroup = "targetgroup/knowre-school-lms-prd/bf6a67da8f259520"
      LoadBalancer = "knowre-school-lms-prd/a20e67095faf6ea8"
    },
    "[trinity-learning-query-rest]" = {
      TargetGroup = "targetgroup/trinity-learning-query-rest-prd/aa134f77e0b0dd1e"
      LoadBalancer = "app/trinity-learning-query-rest-prd/cd05403944090cae"
    },
    "[knowre-school-auth]" = {
      TargetGroup = "targetgroup/knowre-school-auth-prd/43e6458510baa587"
      LoadBalancer = "app/knowre-school-auth-prd/326a5c32379c310b"
    },
    "[trinity-diagnostic-rest]" = {
      TargetGroup = "targetgroup/trinity-diagnostic-rest-prd/ed25a969422b60e2"
      LoadBalancer = "app/trinity-diagnostic-rest-prd/0aa864ca88cfee0b"
    },
    "[trinity-learning]" = {
      TargetGroup = "targetgroup/trinity-learning-prd/1e4a0e2b1662d337"
      LoadBalancer = "app/trinity-learning-prd/3a8ad236dafc9abc"
    },
    "[jarvis-auth]" = {
      TargetGroup = "targetgroup/jarvis-auth-prd/9b14c0f8e3a9085e"
      LoadBalancer = "app/jarvis-auth-prd/15199c16c54403f0"
    },
    "[jarvis-payment]" = {
      TargetGroup = "targetgroup/jarvis-payment-prd/05ae1a5e6aa079e7"
      LoadBalancer = "app/jarvis-payment-prd/bc2dc0435a3914a2"
    },
    "[jarvis-learning]" = {
      TargetGroup = "targetgroup/jarvis-learning-prd/eeb18052bb4e7272"
      LoadBalancer = "app/jarvis-learning-prd/f1c7dc12242fb662"
    }
  }

  enable_crit              = true
  threshold_crit           = 20
  ok_actions_crit          = true
  alarm_actions_crit       = [dependency.sns_topic_common.outputs.sns_topic_arn]
  # extended_statistic = var.extended_statistic
}

