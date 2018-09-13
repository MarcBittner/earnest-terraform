/*
This is the main terraform and aws providers.
The TF state is to be maintained in AWS S3/DynamoDB.
*/

/*
export AWS_ACCESS_KEY_ID="KEY_ID_HERE"
export AWS_SECRET_ACCESS_KEY="SECRET_KEY_HERE"
*/

terraform {
  backend "s3" {
    bucket         = "ring-splunk"
    key            = "splunk/v1/terraform.tfstate"
    encrypt        = "true"
    region         = "us-east-1"
    dynamodb_table = "splunk-tf"
    profile        = "data"
  }
}

provider "aws" {
  region                  = "us-east-1"
  profile                 = "${terraform.workspace == "default" ? "data" : terraform.workspace}"
}

data "aws_caller_identity" "current" {}

output "account_id" {
  value = "${data.aws_caller_identity.current.account_id}"
}

output "caller_arn" {
  value = "${data.aws_caller_identity.current.arn}"
}

output "caller_user" {
  value = "${data.aws_caller_identity.current.user_id}"
}