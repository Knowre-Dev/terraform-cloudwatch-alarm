
terraform {
  source = "git::ssh://git@github.com/Knowre-Dev/terraform-service-repo.git//s3/s3-log?ref=dev"
}

include {
  path = "${find_in_parent_folders()}"
}

inputs ={
  name          = "log-ssm"
  attributes    = ["s3"]
  region        = "ap-northeast-2"

  transition = [
    {
      days          = 30
      storage_class = "STANDARD_IA"
    }, {
      days          = 90
      storage_class = "ONEZONE_IA"
    }
  ]
  expiration_days                              = 1800
  abort_incomplete_multipart_upload_days       = 1
}
