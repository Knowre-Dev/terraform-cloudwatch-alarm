terraform {
  source = "git::ssh://git@github.com/Knowre-Dev/terraform-service-repo.git//ec2-instance?ref=main"
}

include {
    path = find_in_parent_folders()
}

dependency "iam_role" {
  config_path = "../../iam/role"
}

dependency "sg_instance" {
  config_path = "../../sg"
}

# dependency "default_ec2_sg" {
#   config_path = "../../../default/security_group/ec2"
# }

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}

inputs = {
    name                    = "nat-instance"
    application             = local.common_vars.application
    suffix_name             = "02"
    base_ami_tag_name       = "apne2-base-amazon-2023-ami"
    instance_type           = "c5n.large"
    vpc_security_group_ids  = [dependency.sg_instance.outputs.this_security_group_id]
    subnet_id               = local.common_vars.public_subnet_ids[1] #"subnet-0aaac4cae2c4e31bc"
    iam_instance_profile    = dependency.iam_role.outputs.iam_instance_profile_name
    associate_public_ip_address = true
    associate_eip           = false
    source_dest_check       = false

    user_data = templatefile("../user_data.tpl",{
      aws_region  = local.common_vars.region
    })

    root_block_device = [
        {
            delete_on_termination = true
            iops                  = 3000
            volume_size           = 30
            volume_type           = "gp3"
        },
    ]

    key_name           = local.common_vars.ssh_key_name #"knowre-development-ssh-key"
}
