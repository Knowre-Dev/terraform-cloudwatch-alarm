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
  name          = "nat-instance"
  application   = local.common_vars.application
  vpc_id        = local.common_vars.vpc_id #"vpc-062ef72cc16588593"
  attributes    = ["ec2"]
  description   = "Security group for nat-instance"

# https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/rules.tf
  ingress_with_cidr_blocks = [
    {
      rule        = "all-all"
      cidr_blocks = "10.11.176.0/22"
    },
    {
      rule        = "ssh-tcp"
      cidr_blocks = "10.11.0.0/16"
    }
  ]
}