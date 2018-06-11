output "aws_security_group.allow_all.id" {
  value = "${module.vpc.aws_security_group.allow_all.id}"
}

output "subnets.public.ids" {
  value = "${module.vpc.subnets.public.ids}"
}

output "subnets.private.ids" {
  value = "${module.vpc.subnets.private.ids}"
}

output "aws_vpc.id" {
  value = "${module.vpc.vpc.id}"
}
