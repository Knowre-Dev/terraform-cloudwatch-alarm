terraform {
  source = "git::ssh://git@github.com/Knowre-Dev/terraform-service-repo.git//iam/iam-assume-role?ref=main"
}

include {
  path = find_in_parent_folders()
}

dependency "policy_service" {
  config_path = "../policy"
}

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}

inputs ={
  name          = "poc-vod-vpc-peering"

  create_role             = true
  role_requires_mfa       = false

  trusted_role_arns       = ["arn:aws:iam::524525419461:root"]    # access from dev account

  custom_role_policy_arns = [
    "${dependency.policy_service.outputs.arn}"
  ]
}