terraform {
  backend "s3" {
    bucket         = "ring-terraform-practice"
    key            = "implementations/ring-socket-server"
    region         = "us-east-1"
    profile        = "ring-dev"
    dynamodb_table = "ring-terraform_lock_table-practice"
  }
}

provider "aws" {
  profile = "${module.generic-data.environment-profile-mapping[terraform.workspace]}"
  region  = "${module.generic-data.environment-region-mapping[terraform.workspace]}"
}

module "generic-data" {
  source = "../../modules/generic-data"
}
