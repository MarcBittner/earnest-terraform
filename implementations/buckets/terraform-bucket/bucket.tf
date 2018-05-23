resource "aws_s3_bucket" "ring-terraform-states-practice" {
  provider = "aws.dev"
  acl      = "private"
  bucket   = "ring-terraform-states-practice"

  versioning {
    enabled = "true"
  }
}
