terraform {
  backend "s3" {
    bucket         = "ring-terraform-states"
    key            = "implementations/vpc"
    region         = "us-east-1"
    profile        = "ring-it"
    dynamodb_table = "ring-terraform_lock_table"
  }
}

locals {
  env = "${element(split("-", terraform.workspace), 0)}"
}

provider "aws" {
  profile = "${module.generic-data.environment-profile-mapping[local.env]}"
  region  = "${module.generic-data.environment-region-mapping[local.env]}"
}

module "generic-data" {
  source = "../../modules/generic-data"
}
