output "s3_log_bucket_id" {
  value = "${aws_s3_bucket.splunk_s3.id}"
}

output "s3_elbaccess_path" {
  value = "elb_access"
}

output "s3_s3access_path" {
  value = "s3_access"
}
