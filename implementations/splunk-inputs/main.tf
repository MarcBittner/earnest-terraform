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
  config_name      = "default"
  cloudtrail_name  = "default"
}

# # example elastic_load_balancer. Access logs must use the following vars : s3_log_bucket_id and s3_elbaccess_path
#
# resource "aws_elb" "test-elb" {
#   name               = "test-elb"
#   availability_zones = ["us-east-1a"]
#
#   access_logs {
#     bucket        = "${module.splunk.s3_log_bucket_id}"
#     bucket_prefix = "${module.splunk.s3_elbaccess_path}"
#     interval      = 5
#   }
#
#   listener {
#     instance_port     = 8000
#     instance_protocol = "http"
#     lb_port           = 80
#     lb_protocol       = "http"
#   }
# }
#
# # example s3 access logs. Logging must use the following vars : s3_log_bucket_id and s3_s3access_path
#
# resource "aws_s3_bucket" "test-bucket" {
#   bucket        = "my-test-bucket-for-logs"
#   acl           = "private"
#   force_destroy = true
#
#   logging {
#     target_bucket = "${module.splunk.s3_log_bucket_id}"
#     target_prefix = "${module.splunk.s3_s3access_path}"
#   }
# }
#
# #example of cloudfront
#
# resource "aws_cloudfront_distribution" "s3_distribution" {
#   origin {
#     domain_name = "${aws_s3_bucket.test-bucket.bucket_regional_domain_name}"
#     origin_id   = "myS3Origin"
#
#     s3_origin_config {
#       origin_access_identity = "${aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path}"
#     }
#   }
#
#   enabled             = true
#   comment             = "Some comment"
#   default_root_object = "index.html"
#
#   logging_config {
#     include_cookies = false
#     bucket          = "${module.splunk.s3_domain_name}"
#     prefix          = "${module.splunk.s3_cf_path}"
#   }
#
#   default_cache_behavior {
#     allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = "myS3Origin"
#
#     forwarded_values {
#       query_string = false
#
#       cookies {
#         forward = "none"
#       }
#     }
#
#     viewer_protocol_policy = "allow-all"
#     min_ttl                = 0
#     default_ttl            = 3600
#     max_ttl                = 86400
#   }
#
#   restrictions {
#     geo_restriction {
#       restriction_type = "whitelist"
#       locations        = ["US", "CA", "GB", "DE"]
#     }
#   }
#
#   tags {
#     Environment = "production"
#   }
#
#   viewer_certificate {
#     cloudfront_default_certificate = true
#   }
# }
#
# resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
#   comment = "Some comment"
# }
