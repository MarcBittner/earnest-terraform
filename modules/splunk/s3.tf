data "aws_elb_service_account" "main" {}
data "aws_billing_service_account" "main" {}

resource "aws_s3_bucket" "splunk_s3" {
  bucket        = "ring-sec-splunk-${var.aws_account_name}"
  acl           = "log-delivery-write"
  force_destroy = true

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = false
  }

  tags = "${merge(local.common_tags, map("Name", "ring-sec-splunk-${var.aws_account_name}-s3"))}"
}

resource "aws_s3_bucket_policy" "splunk_s3_policy" {
  bucket = "${aws_s3_bucket.splunk_s3.id}"

  policy = "${data.aws_iam_policy_document.splunk_s3_policy.json}"
}

data "aws_iam_policy_document" "splunk_s3_policy" {
  statement {
    sid = "ring-sec-splunk-${var.aws_account_name}-s3"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com", "config.amazonaws.com"]
    }

    principals {
      type        = "AWS"
      identifiers = ["${data.aws_elb_service_account.main.arn}", "${data.aws_billing_service_account.main.arn}"]
    }

    actions = ["s3:GetBucketAcl"]

    resources = ["${aws_s3_bucket.splunk_s3.arn}"]
  }

  statement {
    sid = "AWSCloudTrailWrite"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com", "config.amazonaws.com"]
    }

    principals {
      type        = "AWS"
      identifiers = ["${data.aws_elb_service_account.main.arn}", "${data.aws_billing_service_account.main.arn}"]
    }

    actions = ["s3:PutObject"]

    resources = ["${aws_s3_bucket.splunk_s3.arn}/*"]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"

      values = ["bucket-owner-full-control"]
    }
  }
}
