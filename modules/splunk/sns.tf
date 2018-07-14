/*
  Creates the following sns queues
	"arn:aws:sns:${aws_region}:${aws_account_id}:ring-sec-splunk-${aws_account_name}-cloudtrail",
	"arn:aws:sns:${aws_region}:${aws_account_id}:ring-sec-splunk-${aws_account_name}-cloudfront",
	"arn:aws:sns:${aws_region}:${aws_account_id}:ring-sec-splunk-${aws_account_name}-config",
	"arn:aws:sns:${aws_region}:${aws_account_id}:ring-sec-splunk-${aws_account_name}-elb",
	"arn:aws:sns:${aws_region}:${aws_account_id}:ring-sec-splunk-${aws_account_name}-s3access"
*/

resource "aws_sns_topic" "splunk_cloudtrail_sns" {
  name         = "splunk_cloudtrail_sns"
  display_name = "splunk_cloudtrail_sns"
}

resource "aws_sns_topic" "splunk_cloudfront_sns" {
  name         = "splunk_cloudfront_sns"
  display_name = "splunk_cloudfront_sns"
}

resource "aws_sns_topic" "splunk_config_sns" {
  name         = "splunk_config_sns"
  display_name = "splunk_config_sns"
}

resource "aws_sns_topic" "splunk_elb_sns" {
  name         = "splunk_elb_sns"
  display_name = "splunk_elb_sns"
}

resource "aws_sns_topic" "splunk_s3access_sns" {
  name         = "splunk_s3access_sns"
  display_name = "splunk_s3access_sns"
}

resource "aws_sns_topic_subscription" "splunk_cloudtrail" {
  topic_arn = "${aws_sns_topic.splunk_cloudtrail_sns.arn}"
  protocol  = "sqs"
  endpoint  = "${aws_sqs_queue.splunk_cloudtrail_queue.arn}"
}

resource "aws_sns_topic_subscription" "splunk_cloudfront" {
  topic_arn = "${aws_sns_topic.splunk_cloudfront_sns.arn}"
  protocol  = "sqs"
  endpoint  = "${aws_sqs_queue.splunk_cloudfront_queue.arn}"
}

resource "aws_sns_topic_subscription" "splunk_config" {
  topic_arn = "${aws_sns_topic.splunk_config_sns.arn}"
  protocol  = "sqs"
  endpoint  = "${aws_sqs_queue.splunk_config_queue.arn}"
}

resource "aws_sns_topic_subscription" "splunk_elb" {
  topic_arn = "${aws_sns_topic.splunk_elb_sns.arn}"
  protocol  = "sqs"
  endpoint  = "${aws_sqs_queue.splunk_elb_queue.arn}"
}

resource "aws_sns_topic_subscription" "splunk_s3access" {
  topic_arn = "${aws_sns_topic.splunk_s3access_sns.arn}"
  protocol  = "sqs"
  endpoint  = "${aws_sqs_queue.splunk_s3access_queue.arn}"
}

resource "aws_sns_topic_policy" "splunk_cloudtrail" {
  arn = "${aws_sns_topic.splunk_cloudtrail_sns.arn}"

  policy = "${data.aws_iam_policy_document.splunk_cloudtrail.json}"
}

data "aws_iam_policy_document" "splunk_cloudtrail" {
  statement {
    sid = "ring-sec-splunk-${var.aws_account_name}-cloudtrail"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = ["SNS:Publish"]

    resources = ["${aws_sns_topic.splunk_cloudtrail_sns.arn}"]
  }
}
