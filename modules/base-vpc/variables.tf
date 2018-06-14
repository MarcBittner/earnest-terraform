variable "external-allow-all-cidrs" {
  default = []
}

variable "region-az-count-mapping" {
  type = "map"

  default = {
    "us-west-1"    = 3
    "us-west-2"    = 3
    "us-east-1"    = 6
    "us-east-2"    = 3
    "eu-west-1"    = 3
    "eu-west-2"    = 3
    "eu-central-1" = 3
  }
}

variable "number-to-letter-mapping" {
  type = "map"

  default = {
    "0" = "a"
    "1" = "b"
    "2" = "c"
    "3" = "d"
    "4" = "e"
    "5" = "f"
  }
}

variable "cidr_base" {}

variable "account_id" {}

variable "is_leaf_hub" {
  default = false
}

variable "region" {
  default = "us-east-1"
}

variable "name" {}

variable "private_subnet_tags" {
  type = "map"

  default = {
    "kubernetes.io/cluster/default" = "shared"
  }
}

variable "public_subnet_tags" {
  type = "map"

  default = {
    "kubernetes.io/cluster/default" = "shared"
  }
}

variable "public_nat_subnet_tags" {
  type = "map"

  default = {
    "kubernetes.io/cluster/default" = "shared"
  }
}

variable "private_elb_subnet_tags" {
  type = "map"

  default = {
    "kubernetes.io/cluster/default" = "shared"
  }
}

variable "private_tooling_subnet_tags" {
  type = "map"

  default = {
    "kubernetes.io/cluster/default" = "shared"
  }
}

variable "fortknox_subnet_tags" {
  type = "map"

  default = {
    "kubernetes.io/cluster/default" = "shared"
  }
}
