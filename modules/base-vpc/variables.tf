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
    "1" = "a"
    "2" = "b"
    "3" = "c"
    "4" = "d"
    "5" = "e"
    "6" = "f"
  }
}

variable "cidr_base" {}
variable "region" {}
variable "name" {}

variable "private_subnet_tags" {
  type = "map"

  default = {
    "kubernetes.io/cluster/default" = "shared"
  }
}
