/**
 * AWS Config Service
 */

resource "aws_config_delivery_channel" "splunk-config" {
  name           = "${var.config_name}"
  s3_bucket_name = "${aws_s3_bucket.splunk_s3.id}"
  s3_key_prefix  = "config"
  sns_topic_arn  = "${aws_sns_topic.splunk_config_sns.arn}"

  snapshot_delivery_properties = {
    delivery_frequency = "${var.config_delivery_frequency}"
  }
}


// check if resource exist
