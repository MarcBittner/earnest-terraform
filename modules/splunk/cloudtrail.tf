resource "aws_cloudtrail" "splunk" {
  name                  = "${var.cloudtrail_name}"
  s3_bucket_name        = "${aws_s3_bucket.splunk_s3.id}"
  s3_key_prefix         = "cloudtrail"
  is_multi_region_trail = true
  sns_topic_name        = "${aws_sns_topic.splunk_cloudtrail_sns.arn}"

  event_selector = {
    read_write_type           = "All"
    include_management_events = true
  }

  tags = "${merge(local.common_tags, map("Name", "${var.cloudtrail_name}"))}"
}
