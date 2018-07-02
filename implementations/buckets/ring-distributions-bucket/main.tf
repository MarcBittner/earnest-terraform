terraform {
  backend "s3" {
    bucket         = "ring-terraform-states"
    key            = "implementations/ring-distributions-bucket"
    region         = "us-east-1"
    profile        = "ring-it"
    dynamodb_table = "ring-terraform_lock_table"
  }
}

provider "aws" {
  profile = "ring-it"
  region  = "us-east-1"
}
