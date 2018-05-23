terraform {
  backend "s3" {
    bucket  = "ring-terraform-states-practice"
    key     = "implementations/dynamo/terraform-lock-table"
    region  = "us-east-1"
    profile = "dev-ring"
  }
}

provider "aws" {
  alias   = "dev"
  profile = "dev-ring"
  region  = "us-east-1"
}
