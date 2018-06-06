variable "name" {
  description = "The name of the Security Group"
}

variable "vpc_id" {
  description = "The VPC to associate the Security Group with"
}

variable "ingress_rules" {
  description = "The inbound security group rules"
  type        = "list"
}

variable "egress_rules" {
  description = "The outbound security group rules"
  type        = "list"
}
