module "vpc" {
  source    = "../../modules/base-vpc/"
  name      = "rss-${terraform.workspace}-vpc"
  region    = "${module.generic-data.environment-region-mapping[terraform.workspace]}"
  cidr_base = "${var.vpc-base-cidr[terraform.workspace]}"

  #   private_subnet_tags = {
  #     "kubernetes.io/cluster/k8s.practice.ring.com" = "shared"
  #   }
}
