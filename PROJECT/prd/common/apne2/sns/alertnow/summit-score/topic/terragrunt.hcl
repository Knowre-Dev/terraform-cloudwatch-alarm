terraform {
  source = "git::ssh://git@github.com/Knowre-Dev/terraform-service-repo.git//sns/topic?ref=main"
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

inputs = {
  name = "alertnow-summit-score"
  attribute = "topic"
}
