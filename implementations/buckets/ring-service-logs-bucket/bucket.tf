resource "aws_s3_bucket" "logging_bucket" {
  bucket = "ring-service-logs"
  acl    = "private"

  tags {
    Name = "ring-service-logs"
  }
}
