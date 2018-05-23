module "vpc" {
  source    = "../../modules/base-vpc/"
  name      = "${terraform.workspace}"
  region    = "${join("-", slice(split("-", terraform.workspace), 1, length(split("-", terraform.workspace))))}"
  cidr_base = "10.99"

  private_subnet_tags = {
    "kubernetes.io/cluster/k8s.practice.ring.com" = "shared"
  }
}
