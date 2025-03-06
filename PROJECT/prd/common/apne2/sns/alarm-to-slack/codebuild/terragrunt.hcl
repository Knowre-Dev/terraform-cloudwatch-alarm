terraform {
  source = "git::ssh://git@github.com/Knowre-Dev/terraform-service-repo.git//sns/topic?ref=main"
}

terraform_version_constraint = ">= 0.12"

include {
  path = "${find_in_parent_folders()}"
}

dependencies {
  paths = []
}

inputs = {
  name = "slack-alarm-codebuild"
  application = "mgmt-infra"
}
