terraform {
  source = "git::ssh://git@github.com/Knowre-Dev/terraform-service-repo.git//security-group?ref=main"
}

include {
  path = find_in_parent_folders()
}

inputs ={
  name          = "mitmproxy"
  vpc_id        = "vpc-062ef72cc16588593"
  attributes    = ["ec2"]
  description   = "Security group for bastion"

  ingress_with_cidr_blocks = [
    {
      description = "ssh"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "121.138.113.70/32"
    },
    {
      description = "ssh"
      from_port   = 8866
      to_port     = 8866
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0" #"121.138.113.70/32"
    }
  ]
}