/*
  Creates the following sqs queues
	"arn:aws:sqs:${aws_region}:${aws_account_id}:ring-sec-splunk-${aws_account_name}-cloudtrail",
	"arn:aws:sqs:${aws_region}:${aws_account_id}:ring-sec-splunk-${aws_account_name}-cloudfront",
	"arn:aws:sqs:${aws_region}:${aws_account_id}:ring-sec-splunk-${aws_account_name}-config",
	"arn:aws:sqs:${aws_region}:${aws_account_id}:ring-sec-splunk-${aws_account_name}-elb",
	"arn:aws:sqs:${aws_region}:${aws_account_id}:ring-sec-splunk-${aws_account_name}-s3access"
*/

resource "aws_sqs_queue" "splunk_cloudtrail_queue" {
  name                       = "ring-sec-splunk-${var.aws_account_name}-cloudtrail"
  delay_seconds              = 0
  fifo_queue                 = false
  max_message_size           = 262144
  message_retention_seconds  = 345600
  receive_wait_time_seconds  = 0
  visibility_timeout_seconds = 300

  # redrive_policy             = "{\"deadLetterTargetArn\":\"${aws_sqs_queue..arn}\",\"maxReceiveCount\":15}"
  tags = "${merge(local.common_tags, map("Name", "ring-sec-splunk-${var.aws_account_name}-cloudtrail"))}"
}

resource "aws_sqs_queue" "splunk_cloudfront_queue" {
  name                       = "ring-sec-splunk-${var.aws_account_name}-cloudfront"
  delay_seconds              = 0
  fifo_queue                 = false
  max_message_size           = 262144
  message_retention_seconds  = 345600
  receive_wait_time_seconds  = 0
  visibility_timeout_seconds = 300

  # redrive_policy             = "{\"deadLetterTargetArn\":\"${aws_sqs_queue..arn}\",\"maxReceiveCount\":15}"
  tags = "${merge(local.common_tags, map("Name", "ring-sec-splunk-${var.aws_account_name}-cloudfront"))}"
}

resource "aws_sqs_queue" "splunk_config_queue" {
  name                       = "ring-sec-splunk-${var.aws_account_name}-config"
  delay_seconds              = 0
  fifo_queue                 = false
  max_message_size           = 262144
  message_retention_seconds  = 345600
  receive_wait_time_seconds  = 0
  visibility_timeout_seconds = 300

  # redrive_policy             = "{\"deadLetterTargetArn\":\"${aws_sqs_queue..arn}\",\"maxReceiveCount\":15}"
  tags = "${merge(local.common_tags, map("Name", "ring-sec-splunk-${var.aws_account_name}-config"))}"
}

resource "aws_sqs_queue" "splunk_elb_queue" {
  name                       = "ring-sec-splunk-${var.aws_account_name}-elb"
  delay_seconds              = 0
  fifo_queue                 = false
  max_message_size           = 262144
  message_retention_seconds  = 345600
  receive_wait_time_seconds  = 0
  visibility_timeout_seconds = 300

  # redrive_policy             = "{\"deadLetterTargetArn\":\"${aws_sqs_queue..arn}\",\"maxReceiveCount\":15}"
  tags = "${merge(local.common_tags, map("Name", "ring-sec-splunk-${var.aws_account_name}-elb"))}"
}

resource "aws_sqs_queue" "splunk_s3access_queue" {
  name                       = "ring-sec-splunk-${var.aws_account_name}-s3access"
  delay_seconds              = 0
  fifo_queue                 = false
  max_message_size           = 262144
  message_retention_seconds  = 345600
  receive_wait_time_seconds  = 0
  visibility_timeout_seconds = 300

  # redrive_policy             = "{\"deadLetterTargetArn\":\"${aws_sqs_queue..arn}\",\"maxReceiveCount\":15}"
  tags = "${merge(local.common_tags, map("Name", "ring-sec-splunk-${var.aws_account_name}-s3access"))}"
}

# atttach the policies

resource "aws_sqs_queue_policy" "splunk_cloudtrail" {
  queue_url = "${aws_sqs_queue.splunk_cloudtrail_queue.id}"
  policy    = "${data.aws_iam_policy_document.aws_cloudtrail_send_policy.json}"
}

data "aws_iam_policy_document" "aws_cloudtrail_send_policy" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = ["sqs:SendMessage"]

    resources = ["${aws_sqs_queue.splunk_cloudtrail_queue.arn}"]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"

      values = ["${aws_sns_topic.splunk_cloudtrail_sns.arn}"]
    }
  }
}

resource "aws_sqs_queue_policy" "splunk_cloudfront" {
  queue_url = "${aws_sqs_queue.splunk_cloudfront_queue.id}"
  policy    = "${data.aws_iam_policy_document.aws_cloudfront_send_policy.json}"
}

data "aws_iam_policy_document" "aws_cloudfront_send_policy" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = ["sqs:SendMessage"]

    resources = ["${aws_sqs_queue.splunk_cloudfront_queue.arn}"]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"

      values = ["${aws_sns_topic.splunk_cloudfront_sns.arn}"]
    }
  }
}

resource "aws_sqs_queue_policy" "splunk_config" {
  queue_url = "${aws_sqs_queue.splunk_config_queue.id}"
  policy    = "${data.aws_iam_policy_document.aws_config_send_policy.json}"
}

data "aws_iam_policy_document" "aws_config_send_policy" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = ["sqs:SendMessage"]

    resources = ["${aws_sqs_queue.splunk_config_queue.arn}"]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"

      values = ["${aws_sns_topic.splunk_config_sns.arn}"]
    }
  }
}

resource "aws_sqs_queue_policy" "splunk_elb" {
  queue_url = "${aws_sqs_queue.splunk_elb_queue.id}"
  policy    = "${data.aws_iam_policy_document.aws_elb_send_policy.json}"
}

data "aws_iam_policy_document" "aws_elb_send_policy" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = ["sqs:SendMessage"]

    resources = ["${aws_sqs_queue.splunk_elb_queue.arn}"]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"

      values = ["${aws_sns_topic.splunk_elb_sns.arn}"]
    }
  }
}

resource "aws_sqs_queue_policy" "splunk_s3access" {
  queue_url = "${aws_sqs_queue.splunk_s3access_queue.id}"
  policy    = "${data.aws_iam_policy_document.aws_s3access_send_policy.json}"
}

data "aws_iam_policy_document" "aws_s3access_send_policy" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = ["sqs:SendMessage"]

    resources = ["${aws_sqs_queue.splunk_s3access_queue.arn}"]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"

      values = ["${aws_sns_topic.splunk_s3access_sns.arn}"]
    }
  }
}
