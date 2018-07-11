terraform {
  backend "s3" {
    bucket         = "ring-terraform-states"
    key            = "implementations/legacy-vpc-peering"
    region         = "us-east-1"
    profile        = "ring-it"
    dynamodb_table = "ring-terraform_lock_table"
  }
}

locals {
  env    = "${element(split("-", terraform.workspace), 0)}"
  region = "${join("-", slice(split("-", terraform.workspace), 1, length(split("-", terraform.workspace))))}"
}

provider "aws" {
  alias   = "corp"
  profile = "ring-it"
  region  = "${local.region}"
}

provider "aws" {
  alias   = "old-prod"
  profile = "ring-old-prod"
  region  = "${local.region}"
}

provider "aws" {
  alias   = "old-dev"
  profile = "ring-old-prod"
  region  = "${local.region}"
}

module "generic-data" {
  source = "../../modules/generic-data"
}
