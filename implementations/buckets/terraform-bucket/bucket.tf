resource "aws_s3_bucket" "ring-terraform-practice" {
  provider = "aws.dev"
  acl = "private"
  bucket = "ring-terraform-practice"

  versioning {
    enabled = "true"
  }
}
