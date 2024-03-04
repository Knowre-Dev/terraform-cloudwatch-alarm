terraform {
  source = "git::ssh://git@github.com/Knowre-Dev/terraform-service-repo.git//lambda?ref=dev"
}

include {
  path = "${find_in_parent_folders()}"
}

inputs ={
  create_role = true
  create_package         = false

  name          = "rds-cost-notice"

  handler       = "main"
  runtime       = "provided.al2"
  architectures = ["arm64"]

  local_existing_package = "./lambda.zip"

  environment_variables = {
    LogLevel    = "INFO"
    SLACK_BOT_TOKEN  = "xoxb-2164588559-4894598060948-ghlsxj11ZJHRGz8ZZIcwqYYd"
    SLACK_CHANNEL = "C186SJGP8" #"C04S1BLHL3E" #"C186SJGP8"
  }

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
            "Action": ["rds:Describe*", "rds:List*", "cloudwatch:Get*", "cloudwatch:List*", "cloudwatch:Describe*"],
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
  allowed_triggers = {
    EventRule = {
      principal  = "events.amazonaws.com"
      source_arn = "arn:aws:events:ap-northeast-2:468720534852:rule/rds-cost-notice-rule"
    }
  }
}