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
    hec_token                  = "276fb33f-f8a0-4487-a1f4-c264d20fe741"
    hec_acknowledgment_timeout = 600
    hec_endpoint_type          = "Event"
    s3_backup_mode             = "FailedEventsOnly"
  }
}
