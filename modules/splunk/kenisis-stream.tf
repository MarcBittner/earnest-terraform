#### Kenisis stream setup Terraform
#### We are going to add a HEC token and a Port open

resource "aws_kinesis_stream" "test_stream" {
  name             = "terraform-kinesis-aws-sec"
  shard_count      = 1
  retention_period = 48

  shard_level_metrics = [
    "IncomingBytes",
    "OutgoingBytes",
  ]

  tags {
    Environment = "security"
  }
}
