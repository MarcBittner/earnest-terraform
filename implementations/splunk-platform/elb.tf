resource "aws_alb" "sh" {
  name               = "splunk-sh"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.splunk_lbs.id}"]
  subnets            = ["${data.aws_subnet_ids.az_subnets.ids}"]
  tags = "${merge(local.common_tags, map("Name", "splunk-sh"))}"
}

resource "aws_alb" "sh_es" {
  name               = "splunk-sh-es"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.splunk_lbs.id}"]
  subnets            = ["${data.aws_subnet_ids.az_subnets.ids}"]
  tags = "${merge(local.common_tags, map("Name", "splunk-sh-es"))}"
}

resource "aws_alb" "sh_rs" {
  name               = "splunk-sh-rs"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.splunk_lbs.id}"]
  subnets            = ["${data.aws_subnet_ids.az_subnets.ids}"]
  tags = "${merge(local.common_tags, map("Name", "splunk-sh-rs"))}"
}

resource "aws_alb" "master" {
  name               = "splunk-master"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.splunk_lbs.id}"]
  subnets            = ["${data.aws_subnet_ids.az_subnets.ids}"]
  tags = "${merge(local.common_tags, map("Name", "splunk-master"))}"
}

resource "aws_alb" "ds" {
  name               = "splunk-ds"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.splunk_lbs.id}"]
  subnets            = ["${data.aws_subnet_ids.az_subnets.ids}"]
  tags = "${merge(local.common_tags, map("Name", "splunk-ds"))}"
}

resource "aws_alb" "hfwd" {
  name               = "splunk-hf-${count.index}"
  count              = "${var.num_hf_instances[terraform.workspace]}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.splunk_lbs.id}"]
  subnets            = ["${data.aws_subnet_ids.az_subnets.ids}"]
  tags = "${merge(local.common_tags, map("Name", "splunk-hf-${count.index}"))}"
}

resource "aws_alb" "p_hfwd" {
  name               = "power-splunk-hf-${count.index}"
  count              = "${var.num_p_hf_instances[terraform.workspace]}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.splunk_lbs.id}"]
  subnets            = ["${data.aws_subnet_ids.az_subnets.ids}"]
  tags = "${merge(local.common_tags, map("Name", "power-splunk-hf-${count.index}"))}"
}


resource "aws_lb_listener" "sh" {
  load_balancer_arn = "${aws_alb.sh.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${var.acm_arn[terraform.workspace]}"

  default_action {
    target_group_arn = "${aws_alb_target_group.splunk_search.arn}"
    type             = "forward"
  }
}

resource "aws_lb_listener" "sh_es" {
  load_balancer_arn = "${aws_alb.sh_es.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${var.acm_arn[terraform.workspace]}"

  default_action {
    target_group_arn = "${aws_alb_target_group.splunk_search_es.arn}"
    type             = "forward"
  }
}

resource "aws_lb_listener" "sh_rs" {
  load_balancer_arn = "${aws_alb.sh_rs.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${var.acm_arn[terraform.workspace]}"

  default_action {
    target_group_arn = "${aws_alb_target_group.splunk_search_rs.arn}"
    type             = "forward"
  }
}


resource "aws_lb_listener" "master" {
  load_balancer_arn = "${aws_alb.master.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${var.acm_arn[terraform.workspace]}"

  default_action {
    target_group_arn = "${aws_alb_target_group.splunk_master.arn}"
    type             = "forward"
  }
}

resource "aws_lb_listener" "ds" {
  load_balancer_arn = "${aws_alb.ds.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${var.acm_arn[terraform.workspace]}"

  default_action {
    target_group_arn = "${aws_alb_target_group.splunk_deploy.arn}"
    type             = "forward"
  }
}

resource "aws_lb_listener" "hfwd" {
  count              = "${var.num_hf_instances[terraform.workspace]}"
  load_balancer_arn = "${element(aws_alb.hfwd.*.arn, count.index)}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${var.acm_arn[terraform.workspace]}"

  default_action {
    target_group_arn = "${element(aws_alb_target_group.splunk_hf.*.arn, count.index)}"
    type             = "forward"
  }
}

resource "aws_lb_listener" "P_hfwd" {
  count              = "${var.num_p_hf_instances[terraform.workspace]}"
  load_balancer_arn = "${element(aws_alb.p_hfwd.*.arn, count.index)}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${var.acm_arn[terraform.workspace]}"

  default_action {
    target_group_arn = "${element(aws_alb_target_group.p_splunk_hf.*.arn, count.index)}"
    type             = "forward"
  }
}
