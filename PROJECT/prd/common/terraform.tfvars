terragrunt = {
    remote_state {
        backend = "s3"

        config {
            encrypt         = true
            bucket          = "prd-apne2-kr-aws-cloudwatch-alarm-terraform-s3"
            key             = "prd/${path_relative_to_include()}/terraform.tfstate"
            region          = "ap-northeast-2"
            dynamodb_table  = "prd-apne2-kr-aws-cloudwatch-alarm-terraform-dynamodb"
        }
    }

    terraform {
        extra_arguments "-var-file" {
            commands = ["${get_terraform_commands_that_need_vars()}"]

            optional_var_files = [
                "${get_tfvars_dir()}/${find_in_parent_folders("globals.tfvars", "ignore")}",
                "${get_tfvars_dir()}/${find_in_parent_folders("locals.tfvars", "ignore")}"
            ]
        }
    }
}
