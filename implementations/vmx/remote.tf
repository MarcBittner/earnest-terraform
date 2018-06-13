data "terraform_remote_state" "vpc" {
  backend = "s3"

  config {
    bucket  = "ring-terraform-states"
    key     = "env:/${terraform.workspace}/implementations/vpc"
    region  = "us-east-1"
    profile = "ring-it"
  }
}
