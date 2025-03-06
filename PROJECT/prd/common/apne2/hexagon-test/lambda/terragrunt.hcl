terraform {
  source = "git::ssh://git@github.com/Knowre-Dev/terraform-service-repo.git//lambda?ref=dev"
}

include {
  path = "${find_in_parent_folders()}"
}

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}

inputs ={
  create_role = true
  create_package         = false

  name          = "hexagon-test"

  handler       = "main"
  runtime       = "nodejs20.x"
  architectures = ["arm64"]

  local_existing_package = "./lambda_framework.zip"

  vpc_subnet_ids = [local.common_vars.private_subnet_ids[0], local.common_vars.private_subnet_ids[1]]
  vpc_security_group_ids = ["sg-0d65c5a6dda93d05c"]

  timeout = 60

  attach_additional_policy  = false

  attach_policy_json = true
  policy_json        = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": ["rds:Describe*", "rds:List*", "cloudwatch:Get*", "cloudwatch:List*", "cloudwatch:Describe*", "ec2:*"],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "iam:CreateServiceLinkedRole",
            "Resource": "arn:aws:iam::*:role/aws-service-role/events.amazonaws.com/AWSServiceRoleForCloudWatchEvents*",
            "Condition": {
                "StringLike": {
                    "iam:AWSServiceName": "events.amazonaws.com"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": ["oam:ListAttachedLinks"],
            "Resource": "arn:aws:oam:*:*:sink/*"
        }
    ]
}
EOF
  create_current_version_allowed_triggers = false
}