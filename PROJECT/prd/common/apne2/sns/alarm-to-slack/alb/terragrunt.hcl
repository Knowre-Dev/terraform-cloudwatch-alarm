terraform {
  source = "../../../../../../../SERVICE/sns/topic"
}

terraform_version_constraint = ">= 0.12"

include {
  path = "${find_in_parent_folders()}"
}

dependencies {
  paths = []
}

inputs = {
  name = "slack-alarm-alb"
}
