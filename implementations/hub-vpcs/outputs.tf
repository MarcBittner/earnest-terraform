output "aws_security_group.allow_all.id" {
  value = "${module.vpc.aws_security_group.allow_all.id}"
}

output "subnets.public.ids" {
  value = "${module.vpc.subnets.public.ids}"
}

output "aws_subnet.public.ids" {
  value = "${module.vpc.subnets.public.ids}"
}

output "subnets.private.ids" {
  value = "${module.vpc.subnets.private.ids}"
}

output "aws_subnet.private.ids" {
  value = "${module.vpc.subnets.private.ids}"
}

output "aws_vpc.id" {
  value = "${module.vpc.vpc.id}"
}

output "cidr" {
  value = "${module.vpc.cidr}"
}

output "aws_route_table.public_nat.id" {
  value = "${module.vpc.aws_route_table.public_nat.id}"
}

output "aws_route_table.private.ids" {
  value = ["${module.vpc.aws_route_table.private.id}"]
}
