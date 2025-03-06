terraform {
  source = "git::ssh://git@github.com/Knowre-Dev/terraform-service-repo.git//security-group?ref=main"
}

include {
  path = find_in_parent_folders()
}

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}

inputs ={
  name          = "hexagon-test"
  application   = "hexagon"
  vpc_id        = local.common_vars.vpc_id
  attributes    = ["ec2"]
  description   = "Security group for hexagon-test"

# https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/rules.tf
  ingress_with_cidr_blocks = [
    {
      rule        = "all-all"
      cidr_blocks = "10.11.0.0/16"
    },
    {
      rule        = "https-443-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "http-80-tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}