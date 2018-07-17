/*
  Creates the following sns queues
	"arn:aws:sns:${aws_region}:${aws_account_id}:ring-sec-splunk-${aws_account_name}-cloudtrail",
	"arn:aws:sns:${aws_region}:${aws_account_id}:ring-sec-splunk-${aws_account_name}-cloudfront",
	"arn:aws:sns:${aws_region}:${aws_account_id}:ring-sec-splunk-${aws_account_name}-config",
	"arn:aws:sns:${aws_region}:${aws_account_id}:ring-sec-splunk-${aws_account_name}-elb",
	"arn:aws:sns:${aws_region}:${aws_account_id}:ring-sec-splunk-${aws_account_name}-s3access"
*/

resource "aws_sns_topic" "splunk_cloudtrail_sns" {
  name         = "sec-ct"
  display_name = "sec-ct"
}

resource "aws_sns_topic" "splunk_cloudfront_sns" {
  name         = "sec-cf"
  display_name = "sec-cf"
}

resource "aws_sns_topic" "splunk_config_sns" {
  name         = "sec-config"
  display_name = "config"
}

resource "aws_sns_topic" "splunk_elb_sns" {
  name         = "sec-elb"
  display_name = "sec-elb"
}

resource "aws_sns_topic" "splunk_s3access_sns" {
  name         = "sec-s3access"
  display_name = "sec-s3access"
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

resource "aws_sns_topic_policy" "splunk_cloudfront" {
  arn = "${aws_sns_topic.splunk_cloudfront_sns.arn}"

  policy = "${data.aws_iam_policy_document.splunk_cf.json}"
}

data "aws_iam_policy_document" "splunk_cf" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions = ["SNS:Publish"]

    resources = ["${aws_sns_topic.splunk_cloudfront_sns.arn}"]

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"

      values = ["${aws_s3_bucket.splunk_s3.arn}"]
    }
  }
}

resource "aws_sns_topic_policy" "splunk_elb" {
  arn = "${aws_sns_topic.splunk_elb_sns.arn}"

  policy = "${data.aws_iam_policy_document.splunk_elb.json}"
}

data "aws_iam_policy_document" "splunk_elb" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions = ["SNS:Publish"]

    resources = ["${aws_sns_topic.splunk_elb_sns.arn}"]

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"

      values = ["${aws_s3_bucket.splunk_s3.arn}"]
    }
  }
}

resource "aws_sns_topic_policy" "splunk_s3" {
  arn = "${aws_sns_topic.splunk_s3access_sns.arn}"

  policy = "${data.aws_iam_policy_document.splunk_s3.json}"
}

data "aws_iam_policy_document" "splunk_s3" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions = ["SNS:Publish"]

    resources = ["${aws_sns_topic.splunk_s3access_sns.arn}"]

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"

      values = ["${aws_s3_bucket.splunk_s3.arn}"]
    }
  }
}
