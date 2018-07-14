/**
 * AWS Config Service
 */

resource "aws_config_configuration_recorder_status" "splunk-config" {
  name       = "default"
  is_enabled = true
  depends_on = ["aws_config_delivery_channel.splunk-config"]
}

resource "aws_config_delivery_channel" "splunk-config" {
  name           = "default"
  s3_bucket_name = "${aws_s3_bucket.splunk_s3.id}"
  s3_key_prefix  = "config"
  sns_topic_arn  = "${aws_sns_topic.splunk_config_sns.arn}"

  snapshot_delivery_properties = {
    delivery_frequency = "${var.config_delivery_frequency}"
  }

  depends_on = ["aws_config_configuration_recorder.splunk-config"]
}

resource "aws_config_configuration_recorder" "splunk-config" {
  name     = "default"
  role_arn = "${aws_iam_role.splunk-role.arn}"

  recording_group = {
    all_supported                 = true
    include_global_resource_types = true
  }
}

// check if resource exist

