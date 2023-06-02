terraform {
  source = "../../../../../../../../SERVICE/cloudwatch/event/event-bridge"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic" {
  config_path = "../../../../../apne2/sns/alarm-to-slack/db-event"
}

inputs = {
  name      = "aws-rds-events"
  role      = "mgt"
  event_pattern = <<PATTERN
{
  "source": [
    "aws.rds"
  ],
  "detail-type": [
    "RDS DB Cluster Event",
    "RDS DB Parameter Group Event",
    "RDS DB Security Group Event"
  ],
  "resources": [
    "arn:aws:rds:ap-northeast-2:468720534852:cluster:sl-lc2csrv-red-prd",
    "arn:aws:rds:ap-northeast-2:468720534852:cluster:sl-acl-red-s",
    "arn:aws:rds:ap-northeast-2:468720534852:cluster:sl-adm-red-s",
    "arn:aws:rds:ap-northeast-2:468720534852:cluster:sl-datcntr-pgsql-prd",
    "arn:aws:rds:ap-northeast-2:468720534852:cluster:prd-apne2-kr-summit-score-aurora-cluster",
    "arn:aws:rds:ap-northeast-2:468720534852:cluster:sl-grafana-red-mgt",
    "arn:aws:rds:ap-northeast-2:468720534852:cluster:sl-hexagon-cms-prd",
    "arn:aws:rds:ap-northeast-2:468720534852:cluster:sl-hexagon-red-prd",
    "arn:aws:rds:ap-northeast-2:468720534852:cluster:sl-hexagon-strapi-red-mgt",
    "arn:aws:rds:ap-northeast-2:468720534852:cluster:sl-knowre-school-auth-red-prd",
    "arn:aws:rds:ap-northeast-2:468720534852:cluster:sl-knowre-school-lms-red-prd",
    "arn:aws:rds:ap-northeast-2:468720534852:cluster:sl-lc0-red-s",
    "arn:aws:rds:ap-northeast-2:468720534852:cluster:sl-lc2ccms-red-mgt",
    "arn:aws:rds:ap-northeast-2:468720534852:cluster:prd-apne2-kr-mowbore-aurora-cluster",
    "arn:aws:rds:ap-northeast-2:468720534852:cluster:sl-mngment-red-mgt",
    "arn:aws:rds:ap-northeast-2:468720534852:cluster:sl-sqr-red-s",
    "arn:aws:rds:ap-northeast-2:468720534852:cluster:sl-summit-score-admin-red-prd",
    "arn:aws:rds:ap-northeast-2:468720534852:cluster:sl-trinity-diagnostic-red-prd",
    "arn:aws:rds:ap-northeast-2:468720534852:cluster:sl-trinity-league-red-prd",
    "arn:aws:rds:ap-northeast-2:468720534852:cluster:prd-apne2-kr-knowre-school-aurora-cluster"
  ]
}
PATTERN

  sns_topic = dependency.sns_topic.outputs.sns_topic_arn
  enabled   = true
}