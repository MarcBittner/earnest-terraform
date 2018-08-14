aws_kinesis_firehose_delivery_stream

resource "aws_kinesis_firehose_delivery_stream" "splunk-stream" {
  name        = "terraform-kinesis-firehose-test-stream"
  destination = "splunk"

  s3_configuration {
    role_arn           = "${aws_iam_role.firehose.arn}"
    bucket_arn         = "${aws_s3_bucket.bucket.arn}"
    buffer_size        = 10
    buffer_interval    = 400
    compression_format = "GZIP"
  }

  splunk_configuration {
    hec_endpoint               = "https://52.91.24.83:443"
    hec_token                  = "43cdb08a-7c0f-4c26-81e5-d5f57e35aa92"
    hec_acknowledgment_timeout = 600
    hec_endpoint_type          = "Event"
    s3_backup_mode             = "FailedEventsOnly"
  }
}
