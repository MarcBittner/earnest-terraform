terraform {
  backend "s3" {
    bucket  = "ring-terraform-states"
    key     = "implementations/dynamo/terraform-lock-table"
    region  = "us-east-1"
    profile = "ring-it"
  }
}

provider "aws" {
  alias   = "dev"
  profile = "old-dev"
  region  = "us-east-1"
}

provider "aws" {
  alias   = "ring-it"
  profile = "ring-it"
  region  = "us-east-1"
}
