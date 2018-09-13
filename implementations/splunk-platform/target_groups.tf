resource "aws_alb_target_group" "splunk_search_rs" {
  name     = "splunk-sh-rs"
  port     = 8000
  protocol = "HTTPS"
  vpc_id   = "${aws_vpc.splunk_vpc.id}"
  target_type = "instance"
  health_check {
    protocol              = "HTTPS"
    interval              = 30
    path                  = "/"
    port                  = "traffic-port"
    timeout               = "5"
    healthy_threshold     = 3
    unhealthy_threshold   = 3
    matcher               = "200,303"
  }
  stickiness {
    type = "lb_cookie"
    enabled = false
  }
  tags = "${merge(local.common_tags, map("Name", "splunk-search-rs"))}"
}

resource "aws_alb_target_group" "splunk_search" {
  name     = "splunk-sh"
  port     = 8000
  protocol = "HTTPS"
  vpc_id   = "${aws_vpc.splunk_vpc.id}"
  target_type = "instance"
  health_check {
    protocol              = "HTTPS"
    interval              = 30
    path                  = "/"
    port                  = "traffic-port"
    timeout               = "5"
    healthy_threshold     = 3
    unhealthy_threshold   = 3
    matcher               = "200,303"
  }
  stickiness {
    type = "lb_cookie"
    enabled = false
  }
  tags = "${merge(local.common_tags, map("Name", "splunk-search"))}"
}

resource "aws_alb_target_group" "splunk_search_es" {
  name     = "splunk-sh-es"
  port     = 8000
  protocol = "HTTPS"
  vpc_id   = "${aws_vpc.splunk_vpc.id}"
  target_type = "instance"
  health_check {
    protocol              = "HTTPS"
    interval              = 30
    path                  = "/"
    port                  = "traffic-port"
    timeout               = "5"
    healthy_threshold     = 3
    unhealthy_threshold   = 3
    matcher               = "200,303"
  }
  stickiness {
    type = "lb_cookie"
    enabled = false
  }
  tags = "${merge(local.common_tags, map("Name", "splunk-search-es"))}"
}

resource "aws_alb_target_group" "splunk_master" {
  name     = "splunk-master"
  port     = 8000
  protocol = "HTTPS"
  vpc_id   = "${aws_vpc.splunk_vpc.id}"
  target_type = "instance"
  health_check {
    protocol              = "HTTPS"
    interval              = 30
    path                  = "/"
    port                  = "traffic-port"
    timeout               = "5"
    healthy_threshold     = 3
    unhealthy_threshold   = 3
    matcher               = "200,303"
  }
  stickiness {
    type = "lb_cookie"
    enabled = false
  }
  tags = "${merge(local.common_tags, map("Name", "splunk-master"))}"
}

resource "aws_alb_target_group" "splunk_hf" {
  name     = "splunk-hf-${count.index}"
  count    = "${var.num_hf_instances[terraform.workspace]}"
  port     = 8000
  protocol = "HTTPS"
  vpc_id   = "${aws_vpc.splunk_vpc.id}"
  target_type = "instance"
  health_check {
    protocol              = "HTTPS"
    interval              = 30
    path                  = "/"
    port                  = "traffic-port"
    timeout               = "5"
    healthy_threshold     = 3
    unhealthy_threshold   = 3
    matcher               = "200,303"
  }
  stickiness {
    type = "lb_cookie"
    enabled = false
  }
  tags = "${merge(local.common_tags, map("Name", "splunk-hf-${count.index}"))}"
}

resource "aws_alb_target_group" "p_splunk_hf" {
  name     = "power-splunk-hf-${count.index}"
  count    = "${var.num_p_hf_instances[terraform.workspace]}"
  port     = 8000
  protocol = "HTTPS"
  vpc_id   = "${aws_vpc.splunk_vpc.id}"
  target_type = "instance"
  health_check {
    protocol              = "HTTPS"
    interval              = 30
    path                  = "/"
    port                  = "traffic-port"
    timeout               = "5"
    healthy_threshold     = 3
    unhealthy_threshold   = 3
    matcher               = "200,303"
  }
  stickiness {
    type = "lb_cookie"
    enabled = false
  }
  tags = "${merge(local.common_tags, map("Name", "power-splunk-hf-${count.index}"))}"
}

resource "aws_alb_target_group" "splunk_deploy" {
  name     = "splunk-deploy"
  port     = 8000
  protocol = "HTTPS"
  vpc_id   = "${aws_vpc.splunk_vpc.id}"
  target_type = "instance"
  health_check {
    protocol              = "HTTPS"
    interval              = 30
    path                  = "/"
    port                  = "traffic-port"
    timeout               = "5"
    healthy_threshold     = 3
    unhealthy_threshold   = 3
    matcher               = "200,303"
  }
  stickiness {
    type = "lb_cookie"
    enabled = false
  }
  tags = "${merge(local.common_tags, map("Name", "splunk-deploy"))}"
}

resource "aws_lb_target_group_attachment" "sh" {
  target_group_arn = "${aws_alb_target_group.splunk_search.arn}"
  target_id        = "${aws_instance.sh.id}"
  port             = 8000
}

resource "aws_lb_target_group_attachment" "sh_es" {
  target_group_arn = "${aws_alb_target_group.splunk_search_es.arn}"
  target_id        = "${aws_instance.sh-es.id}"
  port             = 8000
}

resource "aws_lb_target_group_attachment" "sh_rs" {
  target_group_arn = "${aws_alb_target_group.splunk_search_rs.arn}"
  target_id        = "${aws_instance.rs-sh.id}"
  port             = 8000
}

resource "aws_lb_target_group_attachment" "master" {
  target_group_arn = "${aws_alb_target_group.splunk_master.arn}"
  target_id        = "${aws_instance.master.id}"
  port             = 8000
}

resource "aws_lb_target_group_attachment" "deploy" {
  target_group_arn = "${aws_alb_target_group.splunk_deploy.arn}"
  target_id        = "${aws_instance.ds.id}"
  port             = 8000
}

resource "aws_lb_target_group_attachment" "hf" {
  count            = "${var.num_hf_instances[terraform.workspace]}"
  target_group_arn = "${element(aws_alb_target_group.splunk_hf.*.arn, count.index)}"
  target_id        = "${element(aws_instance.hfwd.*.id, count.index)}"
  port             = 8000
}

resource "aws_lb_target_group_attachment" "p_hf" {
  count            = "${var.num_p_hf_instances[terraform.workspace]}"
  target_group_arn = "${element(aws_alb_target_group.p_splunk_hf.*.arn, count.index)}"
  target_id        = "${element(aws_instance.power_hfwd.*.id, count.index)}"
  port             = 8000
}
