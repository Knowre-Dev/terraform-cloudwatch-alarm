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
  name          = "squid-proxy"
  application   = local.common_vars.application
  vpc_id        = local.common_vars.vpc_id #"vpc-062ef72cc16588593"
  attributes    = ["ec2"]
  description   = "Security group for squid-proxy"

  ingress_with_cidr_blocks = [
    {
      rule        = "https-443-tcp"
      cidr_blocks = "10.0.0.0/8"
    },
    {
      rule        = "http-80-tcp"
      cidr_blocks = "10.0.0.0/8"
    }
  ]
}