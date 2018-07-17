resource "aws_elb" "elb" {
  name                      = "${var.name}"
  security_groups           = ["${var.security_groups}"]
  subnets                   = ["${var.subnets}"]
  cross_zone_load_balancing = true

  access_logs {
    bucket        = "${var.logging_bucket}"
    bucket_prefix = "${var.region}/${var.environment}/${var.name}"
    interval      = 5
  }

  internal                    = "${var.is_internal_load_balancer}"
  listener                    = "${var.listeners}"
  idle_timeout                = "${var.idle_timeout}"
  connection_draining         = "${var.connection_draining}"
  connection_draining_timeout = "${var.connection_draining_timeout}"

  health_check {
    healthy_threshold   = "${var.healthy_threshold}"
    unhealthy_threshold = "${var.unhealthy_threshold}"
    timeout             = "${var.timeout}"
    target              = "${var.target}"
    interval            = "${var.interval}"
  }

  tags {
    Name = "${var.name}"
  }
}

output "name" {
  value = "${aws_elb.elb.name}"
}
