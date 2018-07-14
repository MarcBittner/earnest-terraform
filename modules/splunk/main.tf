provider "aws" {
  region  = "us-east-1"
  profile = "${terraform.workspace == "default" ? "security" : terraform.workspace}"
}
