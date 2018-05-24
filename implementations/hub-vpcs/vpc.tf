module "vpc" {
  source    = "../../modules/base-vpc/"
  name      = "${terraform.workspace}"
  region    = "${local.region}"
  cidr_base = "10.99"

  private_subnet_tags = {
    "kubernetes.io/cluster/k8s.practice.ring.com" = "shared"
  }
}
