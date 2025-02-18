terraform {
    # source = "git::ssh://git@bitbucket.org/spooncast/terraform-ops-lambda-service-repo.git//ec2-backup-tag/event?ref=develop"
    source = "/Users/hyunkim/work/Infra2.0/Terraform/terraform-service-repo/eventbridge"
}


include {
  path = "${find_in_parent_folders()}"
}

dependency "lambda" {
  config_path = "../lambda"
}

inputs = {
  create_bus = false

  name = "rds-cost-notice"

  rules = {
    rds-cost-notice = {
      Name                = "rds-cost-notice"
      description         = "Run 5:00 a.m. UTC every weekday"
      schedule_expression = "cron(0 5 ? * MON-FRI *)"
    }
  }

  targets = {
    rds-cost-notice = [
      {
        name  = "lambda-rds-cost-notice"
        arn   = dependency.lambda.outputs.lambda_function_arn
        input = jsonencode({ "regions" : ["ap-northeast-2", "us-east-1"] })
      }
    ]
  }
}
