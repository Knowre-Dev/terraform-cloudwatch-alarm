terraform {
  source = "git::ssh://git@github.com/Knowre-Dev/terraform-service-repo.git//iam/iam-assume-role?ref=dev"
}

include {
  path = find_in_parent_folders()
}

dependency "policy_service" {
  config_path = "../policy/service"
}

dependency "ssm_policy" {
  config_path = "../../../../global/iam_policy/ssm"
}

inputs ={
  name          = "ci-runner"
  attributes    = ["ec2"]

  create_role             = true
  role_requires_mfa       = false
  create_instance_profile = true

  trusted_role_services = [
    "ec2.amazonaws.com"
  ]

  custom_role_policy_arns = [
    "${dependency.policy_service.outputs.arn}",
    "${dependency.ssm_policy.outputs.arn}"
  ]
}