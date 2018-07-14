provider "aws" {
  region  = "us-east-1"
  profile = "${terraform.workspace == "default" ? "security" : terraform.workspace}"
}

# terraform {
#   backend "s3" {
#     bucket         = "ring-terraform-states"
#     key            = "implementations/splunk-input"
#     region         = "us-east-1"
#     profile        = "ring-it"
#     dynamodb_table = "ring-terraform_lock_table"
#   }
# }

data "aws_vpcs" "vpcs" {}

module "splunk" {
  source           = "../../modules/splunk"
  aws_account_name = "security"
  region           = "us-east-1"
  vpc_ids          = ["${data.aws_vpcs.vpcs.ids}"]
}

# example elastic_load_balancer. Access logs must use the following vars : s3_log_bucket_id and s3_elbaccess_path

resource "aws_elb" "test-elb" {
  name               = "test-elb"
  availability_zones = ["us-east-1"]

  access_logs {
    bucket        = "${module.splunk.s3_log_bucket_id}"
    bucket_prefix = "${module.splunk.s3_elbaccess_path}"
    interval      = 5
  }

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}

# example s3 access logs. Logging must use the following vars : s3_log_bucket_id and s3_s3access_path

resource "aws_s3_bucket" "test-bucket" {
  bucket = "my-test-bucket-for-logs"
  acl    = "private"

  logging {
    target_bucket = "${module.splunk.s3_log_bucket_id}"
    target_prefix = "${module.splunk.s3_s3access_path}"
  }
}
