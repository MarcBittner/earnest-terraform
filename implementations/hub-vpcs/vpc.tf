module "vpc" {
  source    = "../../modules/base-vpc/"
  name      = "${terraform.workspace}"
  region    = "${local.region}"
  cidr_base = "${var.environment-cidr-mapping[terraform.workspace]}"

  is_leaf_hub = "${terraform.workspace == "corp-us-east-1" ? false : true}"
  account_id = "${module.generic-data.environment-account-mapping[local.env]}"

  private_subnet_tags = {
    "kubernetes.io/cluster/k8s.practice.ring.com" = "shared"
  }
}
