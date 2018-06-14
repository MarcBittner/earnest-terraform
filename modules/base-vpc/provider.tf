provider "aws" {
  alias   = "corp"
  profile = "ring-it"
  region  = "${var.region}"
}
