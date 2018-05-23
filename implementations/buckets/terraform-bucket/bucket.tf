resource "aws_s3_bucket" "ring-terraform-states" {
  provider = "aws.ring-it"
  acl      = "private"
  bucket   = "ring-terraform-states"

  versioning {
    enabled = "true"
  }
  
}
