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
  name      = "rds-cluster-events"
  role      = "mgt"
  # name_prefix      = ""

  sns_topic = dependency.sns_topic_db.outputs.sns_topic_arn

  # source_ids  = [
  #   "knowre-lms-devopsms985-cluster",
  #   "kr-dky-red-devopsms974",
  #   "sl-acl-red-b",
  #   "sl-acl-red-s",
  #   "sl-acl-red-u",
  #   "sl-adm-red-s",
  #   "sl-aims-red-u",
  #   "sl-datcntr-pgsql-dev",
  #   "sl-datcntr-pgsql-prd",
  #   "sl-datcntr-pgsql-stg",
  #   "sl-dky-red-b",
  #   "sl-dky-red-s",
  #   "sl-dky-red-u",
  #   "sl-grafana-red-mgt",
  #   "sl-hexagon-cms-dev",
  #   "sl-hexagon-cms-prd",
  #   "sl-hexagon-cms-stg",
  #   "sl-hexagon-red-dev",
  #   "sl-hexagon-red-prd",
  #   "sl-hexagon-red-stg",
  #   "sl-hexagon-strapi-red-mgt",
  #   "sl-jarvis-auth-red-dev",
  #   "sl-jarvis-auth-red-prd",
  #   "sl-jarvis-auth-red-stg",
  #   "sl-jarvis-learning-red-dev",
  #   "sl-jarvis-learning-red-prd",
  #   "sl-jarvis-learning-red-stg",
  #   "sl-jarvis-payment-red-dev",
  #   "sl-jarvis-payment-red-prd",
  #   "sl-jarvis-payment-red-stg",
  #   "sl-knowre-school-auth-red-dev",
  #   "sl-knowre-school-auth-red-prd",
  #   "sl-knowre-school-auth-red-stg",
  #   "sl-knowre-school-lms-red-dev",
  #   "sl-knowre-school-lms-red-prd",
  #   "sl-knowre-school-lms-red-stg",
  #   "sl-lc0-red-s",
  #   "sl-lc0-red-u",
  #   "sl-lc2ccms-red-mgt",
  #   "sl-lc2csrv-red-dev",
  #   "sl-lc2csrv-red-prd",
  #   "sl-lc2csrv-red-stg",
  #   "sl-lc2ucms-red-mgt",
  #   "sl-lcu-red-u",
  #   "sl-mbr-red-s",
  #   "sl-mngment-red-mgt",
  #   "sl-sqr-red-b",
  #   "sl-sqr-red-s",
  #   "sl-sqr-red-u",
  #   "sl-summit-score-admin-red-dev",
  #   "sl-summit-score-admin-red-prd",
  #   "sl-summit-score-admin-red-stg",
  #   "sl-trinity-diagnostic-red-dev",
  #   "sl-trinity-diagnostic-red-prd",
  #   "sl-trinity-diagnostic-red-stg",
  #   "sl-trinity-league-red-dev",
  #   "sl-trinity-league-red-prd",
  #   "sl-trinity-league-red-stg",
  #   "sl-usp-red-d",
  #   "traffic-test-sl-dky-red"
  # ]
  source_type = "db-cluster"

  event_categories = [
    "failover",
    "failure",
    "notification",
    "creation",
    "deletion",
    "maintenance",
    "configuration change",
    "global-failover"
  ] 

  enabled = true
}