terraform {
  source = "git::ssh://git@github.com/Knowre-Dev/terraform-service-repo.git//ec2-instance?ref=dev"
}

include {
    path = find_in_parent_folders()
}

dependency "iam_role" {
  config_path = "../../iam/role"
}

# dependency "sg_instance" {
#   config_path = "../sg/instance"
# }

# dependency "default_ec2_sg" {
#   config_path = "../../default/security_group/ec2"
# }

# dependency "ops_public_subnets" {
#   config_path = "../../network/service/subnets/public/ops"
# }

inputs = {
    name                    = "test-ec2"
    suffix_name             = "03"
    base_ami_tag_name       = "apne2-base-amazon-ami"
    instance_type           = "t3.medium"
    # vpc_security_group_ids  = [dependency.sg_instance.outputs.this_security_group_id, local.common_vars.default_ec2_sg]
    vpc_security_group_ids  = ["sg-0626988b522aa2e02"]
    subnet_id               = "subnet-0f43ff57ee458843c"
    iam_instance_profile    = dependency.iam_role.outputs.iam_instance_profile_name
    # associate_public_ip_address = true
    # associate_eip           = true

    # user_data = templatefile("./user_data.tpl",{
    #     github_repo_url       = "https://github.com/Knowre-Dev",    
    #     github_repo_pat_token = "AXKWCVFQ2YSZMXQUEFMZ3YTC3ER4M",
    #     runner_name           = "legacy-apne2-github-runner-01",
    #     labels                = "github,linux,legacy"
    # })

    # root_block_device = [
    #     {
    #         delete_on_termination = true
    #         iops                  = 3000
    #         volume_size           = 20
    #         volume_type           = "gp3"
    #     },
    # ]

    key_name           = "knowre-development-ssh-key"
}
