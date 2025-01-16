terraform {
  source = "git::ssh://git@github.com/Knowre-Dev/terraform-service-repo.git//iam/iam-assume-role-with-oidc?ref=main"
}

include {
  path = find_in_parent_folders()
}

dependency "policy" {
  config_path = "../policy"
}

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}

inputs ={
  name          = "packer-github"
  attributes    = ["packer"]
  application   = local.common_vars.application

  create_role             = true
  role_requires_mfa       = false
  create_instance_profile = false

  provider_url = "token.actions.githubusercontent.com"

  role_policy_arns = [
    "${dependency.policy.outputs.arn}",
  ]

  oidc_subjects_with_wildcards = [
    "repo:pascal-h-kim/packer-repo:*"
  ]

  oidc_fully_qualified_audiences = [
    "sts.amazonaws.com"
  ]
}