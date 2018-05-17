terraform {
  backend "s3" {
    bucket  = "ring-terraform-practice"
    key     = "implementations/dynamo/terraform-lock-table"
    region  = "us-east-1"
    profile = "ring-dev"
  }
}

provider "aws" {
  alias   = "dev"
  profile = "ring-dev"
  region  = "us-east-1"
}
