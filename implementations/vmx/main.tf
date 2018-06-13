terraform {
  backend "s3" {
    bucket         = "ring-terraform-states"
    key            = "implementations/vmx"
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
  profile = "${module.generic-data.environment-profile-mapping[local.env]}"
  region  = "${local.region}"
}

module "generic-data" {
  source = "../../modules/generic-data"
}
