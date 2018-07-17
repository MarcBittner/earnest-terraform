output "s3_log_bucket_id" {
  description = "Bucket used for logging"
  value       = "${aws_s3_bucket.splunk_s3.id}"
}

output "s3_domain_name" {
  value = "${aws_s3_bucket.splunk_s3.bucket_domain_name}"
}

output "s3_elbaccess_path" {
  value = "elb_access"
}

output "s3_s3access_path" {
  value = "s3_access/"
}

output "s3_cf_path" {
  value = "cloudfront"
}
