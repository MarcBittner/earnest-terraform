variable "old-prod-public-route-tables" {
  default = ["rtb-99ab7bfc", "rtb-9bab7bfe"]
}

variable "old-prod-private-route-tables" {
  default = []
}

variable "old-prod-cidr" {
  default = "172.16.0.0/16"
}
