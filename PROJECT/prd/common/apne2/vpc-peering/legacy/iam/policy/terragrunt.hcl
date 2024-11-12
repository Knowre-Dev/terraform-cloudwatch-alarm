terraform {
  source = "git::ssh://git@github.com/Knowre-Dev/terraform-service-repo.git//iam/iam-policy?ref=main"
}

include {
  path = find_in_parent_folders()
}

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}

inputs ={
  name          = "poc-vod-vpc-peering"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateRoute",
        "ec2:DeleteRoute"
      ],
      "Resource": "arn:aws:ec2:*:${local.common_vars.aws_account_id}:route-table/*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeVpcPeeringConnections",
        "ec2:DescribeVpcs",
        "ec2:ModifyVpcPeeringConnectionOptions",
        "ec2:DescribeSubnets",
        "ec2:DescribeVpcAttribute",
        "ec2:DescribeRouteTables"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:AcceptVpcPeeringConnection",
        "ec2:DeleteVpcPeeringConnection",
        "ec2:CreateVpcPeeringConnection",
        "ec2:RejectVpcPeeringConnection"
      ],
      "Resource": [
        "arn:aws:ec2:*:${local.common_vars.aws_account_id}:vpc-peering-connection/*",
        "arn:aws:ec2:*:${local.common_vars.aws_account_id}:vpc/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DeleteTags",
        "ec2:CreateTags"
      ],
      "Resource": "arn:aws:ec2:*:${local.common_vars.aws_account_id}:vpc-peering-connection/*"
    }
  ]
}
EOF
}