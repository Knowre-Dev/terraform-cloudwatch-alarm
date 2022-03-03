terraform {
  source = "../../../../../../../SERVICE/sns/topic"
}

include {
  path = "${find_in_parent_folders()}"
}

dependencies {
  paths = []
}

inputs = {
  name = "slack-us-alarm-db"
}
