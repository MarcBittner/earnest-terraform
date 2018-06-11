data "terraform_remote_state" "corp_vpc" {
  backend = "s3"

  config {
    bucket  = "ring-terraform-states"
    key     = "env:/corp-us-east-1/implementations/vpc"
    region  = "us-east-1"
    profile = "ring-it"
  }
}
