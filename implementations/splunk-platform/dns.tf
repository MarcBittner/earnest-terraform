variable "dns_zone_name" {
  default = "ring.local"
}

resource "aws_route53_zone" "splunk_53_zone" {
  name   = "${var.dns_zone_name}"
  vpc_id = "${aws_vpc.splunk_vpc.id}"
  tags   = "${merge(local.common_tags, map("Name", "splunk_internal_dns_zone"))}"
}

resource "aws_route53_record" "idx-ns" {
  // same number of records as instances
  count   = "${var.num_idx_instances[terraform.workspace]}"
  zone_id = "${aws_route53_zone.splunk_53_zone.zone_id}"
  name    = "splunk-indexer-${count.index}"
  type    = "A"
  ttl     = "300"
  // matches up record N to instance N
  records = ["${element(aws_instance.idx.*.private_ip, count.index)}"]
}

resource "aws_route53_record" "hfwd-ns" {
  // same number of records as instances
  count   = "${var.num_hf_instances[terraform.workspace]}"
  zone_id = "${aws_route53_zone.splunk_53_zone.zone_id}"
  name    = "splunk-hforwarder-${count.index}"
  type    = "A"
  ttl     = "300"
  // matches up record N to instance N
  records = ["${element(aws_instance.hfwd.*.private_ip, count.index)}"]
}

resource "aws_route53_record" "p-hfwd-ns" {
  // same number of records as instances
  count   = "${var.num_p_hf_instances[terraform.workspace]}"
  zone_id = "${aws_route53_zone.splunk_53_zone.zone_id}"
  name    = "power-splunk-hforwarder-${count.index}"
  type    = "A"
  ttl     = "300"
  // matches up record N to instance N
  records = ["${element(aws_instance.power_hfwd.*.private_ip, count.index)}"]
}

resource "aws_route53_record" "sh-ns" {
  // same number of records as instances
  zone_id = "${aws_route53_zone.splunk_53_zone.zone_id}"
  name    = "splunk-search-ah"
  type    = "A"
  ttl     = "300"
  // matches up record N to instance N
  records = ["${element(aws_instance.sh.*.private_ip, count.index)}"]
}

resource "aws_route53_record" "sh-es-ns" {
  // same number of records as instances
  zone_id = "${aws_route53_zone.splunk_53_zone.zone_id}"
  name    = "splunk-search-es"
  type    = "A"
  ttl     = "300"
  // matches up record N to instance N
  records = ["${element(aws_instance.sh-es.*.private_ip, count.index)}"]
}

resource "aws_route53_record" "sh-rs-ns" {
  // same number of records as instances
  zone_id = "${aws_route53_zone.splunk_53_zone.zone_id}"
  name    = "splunk-search-rs"
  type    = "A"
  ttl     = "300"
  // matches up record N to instance N
  records = ["${element(aws_instance.rs-sh.*.private_ip, count.index)}"]
}

resource "aws_route53_record" "ds-ns" {
  // same number of records as instances
  zone_id = "${aws_route53_zone.splunk_53_zone.zone_id}"
  name    = "splunk-deployment"
  type    = "A"
  ttl     = "300"
  // matches up record N to instance N
  records = ["${element(aws_instance.ds.*.private_ip, count.index)}"]
}

resource "aws_route53_record" "master-ns" {
  // same number of records as instances
  zone_id = "${aws_route53_zone.splunk_53_zone.zone_id}"
  name    = "splunk-master"
  type    = "A"
  ttl     = "300"
  // matches up record N to instance N
  records = ["${element(aws_instance.master.*.private_ip, count.index)}"]
}


resource "aws_route53_record" "public-deploy-ns" {
  // same number of records as instances
  zone_id = "${var.public_zone_id[terraform.workspace]}"
  name    = "splunk-deploy"
  type    = "A"
  alias {
    name                   = "${aws_alb.ds.dns_name}"
    zone_id                = "${aws_alb.ds.zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "public-hf-ns" {
  // same number of records as instances
  count   = "${var.num_hf_instances[terraform.workspace]}"
  zone_id = "${var.public_zone_id[terraform.workspace]}"
  name    = "splunk-hf-${count.index}"
  type    = "A"
  alias {
    name                   = "${element(aws_alb.hfwd.*.dns_name, count.index)}"
    zone_id                = "${element(aws_alb.hfwd.*.zone_id, count.index)}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "public-p-hf-ns" {
  // same number of records as instances
  count   = "${var.num_p_hf_instances[terraform.workspace]}"
  zone_id = "${var.public_zone_id[terraform.workspace]}"
  name    = "power-splunk-hf-${count.index}"
  type    = "A"
  alias {
    name                   = "${element(aws_alb.p_hfwd.*.dns_name, count.index)}"
    zone_id                = "${element(aws_alb.p_hfwd.*.zone_id, count.index)}"
    evaluate_target_health = false
  }
}


resource "aws_route53_record" "public-idx-ns" {
  // same number of records as instances
  count   = "${var.num_idx_instances[terraform.workspace]}"
  zone_id = "${var.public_zone_id[terraform.workspace]}"
  name    = "splunk-indexer-${count.index}"
  type    = "CNAME"
   ttl     = "300"
  records = ["${element(aws_instance.idx.*.public_dns, count.index)}"]
}

resource "aws_route53_record" "public-master-ns" {
  // same number of records as instances
  zone_id = "${var.public_zone_id[terraform.workspace]}"
  name    = "splunk-master"
  type    = "A"
  alias {
    name                   = "${aws_alb.master.dns_name}"
    zone_id                = "${aws_alb.master.zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "public-search-ns" {
  // same number of records as instances
  zone_id = "${var.public_zone_id[terraform.workspace]}"
  name    = "splunk-search"
  type    = "A"
  alias {
    name                   = "${aws_alb.sh.dns_name}"
    zone_id                = "${aws_alb.sh.zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "public-search-es-ns" {
  // same number of records as instances
  zone_id = "${var.public_zone_id[terraform.workspace]}"
  name    = "splunk-search-es"
  type    = "A"
  alias {
    name                   = "${aws_alb.sh_es.dns_name}"
    zone_id                = "${aws_alb.sh_es.zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "public-search-rs-ns" {
  // same number of records as instances
  zone_id = "${var.public_zone_id[terraform.workspace]}"
  name    = "splunk-search-rs"
  type    = "A"
  alias {
    name                   = "${aws_alb.sh_rs.dns_name}"
    zone_id                = "${aws_alb.sh_rs.zone_id}"
    evaluate_target_health = false
  }
}
