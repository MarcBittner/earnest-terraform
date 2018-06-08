module "vpc" {
  source    = "../../modules/base-vpc/"
  name      = "${terraform.workspace}"
  region    = "${local.region}"
  cidr_base = "${var.environment-cidr-mapping[terraform.workspace]}"

  private_subnet_tags = {
    "kubernetes.io/cluster/k8s.practice.ring.com" = "shared"
  }
}
