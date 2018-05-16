terraform {
  backend "s3" {
    bucket         = "ring-terraform-practice"
    key            = "implementations/vpc"
    region         = "us-east-1"
    profile        = "ring-dev"
    dynamodb_table = "ring-terraform_lock_table-stage"
  }
}

provider "aws" {
  profile = "${generic-data.environment-profile-mapping[terraform.workspace]}"
  region  = "${generic-data.environment-region-mapping[terraform.workspace]}"
}

module "generic-data" {
  source = "../../modules/generic-data"
}
