terraform {
  source = "git::ssh://git@github.com/Knowre-Dev/terraform-service-repo.git//iam/iam-policy?ref=dev"
}

terraform_version_constraint = ">= 0.14"

include {
  path = "${find_in_parent_folders()}"
}

dependencies {
  paths = []
}

inputs = {

  name                = "ssm"
  attributes          = ["policy"]
  description         = "Default policy for registering in session manager."
  policy              =  <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ssm:ListAssociations",
                "ssm:ListInstanceAssociations",
                "ssm:UpdateInstanceInformation"                
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ssmmessages:CreateControlChannel",
                "ssmmessages:CreateDataChannel",
                "ssmmessages:OpenControlChannel",
                "ssmmessages:OpenDataChannel"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:DescribeLogGroups",
                "logs:DescribeLogStreams"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2messages:AcknowledgeMessage",
                "ec2messages:DeleteMessage",
                "ec2messages:FailMessage",
                "ec2messages:GetEndpoint",
                "ec2messages:GetMessages",
                "ec2messages:SendReply"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetBucketLocation",
                "s3:PutObject",
                "s3:GetObject",
                "s3:GetEncryptionConfiguration",
                "s3:AbortMultipartUpload",
                "s3:ListMultipartUploadParts",
                "s3:ListBucket",
                "s3:ListBucketMultipartUploads"
            ],
            "Resource": [
                "arn:aws:s3:::prd-apne2-log-ssm-s3",
                "arn:aws:s3:::prd-apne2-log-ssm-s3/*"
            ]
        }
    ]
}
EOF
}

