terraform {
  backend "s3" {
    bucket         = "ring-terraform-states"
    key            = "implementations/vpc"
    region         = "us-east-1"
    profile        = "ring-it"
    dynamodb_table = "ring-terraform_lock_table"
  }
}

provider "aws" {
  profile = "${terraform.workspace}"
  region  = "${module.generic-data.environment-region-mapping[terraform.workspace]}"
}

module "generic-data" {
  source = "../../modules/generic-data"
}
