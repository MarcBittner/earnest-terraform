terraform {
  backend "s3" {
    bucket  = "ring-terraform-practice"
    key     = "implementations/dynamo/terraform-lock-table"
    region  = "us-east-1"
    profile = "dev"
  }
}

provider "aws" {
  alias   = "dev"
  profile = "dev"
  region  = "us-east-1"
}
