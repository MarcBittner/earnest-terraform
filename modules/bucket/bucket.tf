resource "aws_s3_bucket" "bucket" {
  acl    = "private"
  bucket = "${var.name}"

  versioning {
    enabled = "${var.enable_versioning}"
  }
}

variable "name" {
  type = "string"
}

variable "enable_versioning" {
  default = true
}
