output "dns_name" {
  value = "${aws_elb.elb.dns_name}"
}

output "zone_id" {
  value = "${aws_elb.elb.zone_id}"
}
