variable "old-prod-public-route-tables" {
  default = []
}

variable "old-prod-private-route-tables" {
  default = ["rtb-99ab7bfc"]
}

variable "old-prod-cidr" {
  default = "172.16.0.0/16"
}
