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



inputs = {
    name                    = "mitmproxy"
    suffix_name             = "01"
    base_ami_tag_name       = "apne2-base-amazon-ami"
    instance_type           = "t3.micro"
    vpc_security_group_ids  = [dependency.sg_instance.outputs.this_security_group_id]
    subnet_id               = "subnet-0aaac4cae2c4e31bc"
    iam_instance_profile    = dependency.iam_role.outputs.iam_instance_profile_name
    associate_public_ip_address = true
    associate_eip           = true

    root_block_device = [
        {
            delete_on_termination = true
            iops                  = 3000
            volume_size           = 30
            volume_type           = "gp3"
        },
    ]

    key_name           = "knowre-development-ssh-key"
}
