terraform {
  source = "git::ssh://git@github.com/Knowre-Dev/terraform-service-repo.git//iam/iam-assume-role?ref=main"
}

include {
  path = find_in_parent_folders()
}

dependency "ssm_policy" {
  config_path = "../../../../global/iam_policy/ssm"
}

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}

inputs ={
  name          = "squid-proxy"
  attributes    = ["ec2"]
  application   = local.common_vars.application

  create_role             = true
  role_requires_mfa       = false
  create_instance_profile = true

  trusted_role_services = [
    "ec2.amazonaws.com"
  ]

  custom_role_policy_arns = [
    "${dependency.ssm_policy.outputs.arn}"
  ]
}