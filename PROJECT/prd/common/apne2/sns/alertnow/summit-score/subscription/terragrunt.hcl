terraform {
  source = "git::ssh://git@github.com/Knowre-Dev/terraform-service-repo.git//sns/subscription?ref=main"
}

include {
  path = "${find_in_parent_folders()}"
}

dependencies {
  paths = []
}

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}

dependency "sns" {
  config_path = "../topic"
}

inputs = {
  name        = "alertnow-summit-score"
  attribute   = "subscription"
  topic_arn   = dependency.sns.outputs.sns_topic_arn
  aws_region  = "ap-northeast-2"
  subscribers = [
    {
      protocol  = "https"
      endpoint  = "https://alertnowitgr.opsnow.com/integration/cloudwatch/v1/39717c9c1e729711ee4974a8024b062bd2e6"
    }
  ]
}
