terraform {
  source = "git::ssh://git@github.com/Knowre-Dev/terraform-service-repo.git//lambda?ref=dev"
}

include {
  path = "${find_in_parent_folders()}"
}

inputs ={
  create_role = true
  create_package         = false

  name          = "slack-user-notice"

  handler       = "main"
  runtime       = "go1.x"

  local_existing_package = "./lambda.zip"

  environment_variables = {
    LogLevel    = "INFO"
    SlackToken  = "xoxb-2164588559-4894598060948-pBHfsHzJo0GL3fnw41W42oPV"
  }

  timeout = 60

  attach_additional_policy  = false

#   attach_policy_json = true
#   policy_json        = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Sid": "VisualEditor0",
#             "Effect": "Allow",
#             "Action": "rds:DescribeExportTasks",
#             "Resource": "*"
#         }
#     ]
# }
# EOF
  
}