// Security Group To Manage Traffic For Splunk Servers

/* This is the default base splunk security group. used on all splunk instances. */
resource "aws_security_group" "splunk_default_sec_group" {
  name        = "splunk_default_sec_group"
  description = "Splunk Default Security Group"
  vpc_id      = "${aws_vpc.splunk_vpc.id}"

  tags = "${merge(local.common_tags, map("Name", "splunk_default_sec_group"))}"

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["${var.splunk_vpc_cidr}"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.lax16_cidr}"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.splunk_vpc_cidr}"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.static_ip_list}"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["${var.static_ip_list}"]
  }

  ingress {
    from_port   = 8089
    to_port     = 8089
    protocol    = "tcp"
    cidr_blocks = ["${var.splunk_vpc_cidr}"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["104.173.11.82/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #BG: added changes to match Jon's manual security group adds.  Some of these ingress rules would be better suited for inclusion in the static ip list
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["69.26.152.132/32"]
    description = "Marc"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["176.100.19.145/32"]
    description = "mykyta drapatyi: Remove this if needed"
  }

  ingress {
    from_port   = 8089
    to_port     = 8089
    protocol    = "tcp"
    cidr_blocks = ["54.89.115.155/32"]
    description = "Phantom master"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["54.89.115.155/32"]
    description = "phantom master"
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["205.251.233.179/32", "72.21.198.67/32", "205.251.233.178/32"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["69.26.152.132/32"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["217.20.170.129/32"]
    description = "mykyta drapatyi: Kiev office Remove this if needed"
  }
}

/* This group is meant for the splunk indexers only. */
resource "aws_security_group" "splunk_indexer_sec_group" {
  name = "splunk_indexer_sec_group"

  description = "Splunk Indexer Security Group"
  vpc_id      = "${aws_vpc.splunk_vpc.id}"

  tags = "${merge(local.common_tags, map("Name", "splunk_indexer_sec_group"))}"

  ingress {
    from_port   = 9997
    to_port     = 9997
    protocol    = "tcp"
    cidr_blocks = ["${var.splunk_vpc_cidr}"]
  }

  ingress {
    from_port   = 8091
    to_port     = 8091
    protocol    = "tcp"
    cidr_blocks = ["${var.splunk_vpc_cidr}"]
  }
}

/* This group is to manage the syslog ingress from the various meraki endpoints. */
resource "aws_security_group" "meraki_ingress_group" {
  name = "splunk_meraki_ingress_group"

  description = "Meraki Ingress Security Group"
  vpc_id      = "${aws_vpc.splunk_vpc.id}"
  tags        = "${merge(local.common_tags, map("Name", "splunk_meraki_ingress_group"))}"

  ingress {
    description = "Meraki Cluster"
    from_port   = 6516
    to_port     = 6516
    protocol    = "udp"
    cidr_blocks = ["${var.meraki_endpoints}"]
  }
}

/*
This is to manage the ui access to splunk. We are ONLY opening 80 for UI redirects.
If this is unclear, it is so when client requests http://some-splunk:80, user gets 302 onto https://some-splunk:443.
This is/will-be managed by nginx.
 */
resource "aws_security_group" "splunk_ui" {
  name        = "splunk_user_interface"
  description = "Splunk Web Security Group"
  vpc_id      = "${aws_vpc.splunk_vpc.id}"
  tags        = "${merge(local.common_tags, map("Name", "splunk_user_interface"))}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.sm_office_one}"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.sm_office_two}"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.brett_home}"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.bryan_home}"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.sm_office_one}"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.sm_office_two}"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.brett_home}"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.bryan_home}"]
  }
}

/* This is to manage the cylance ingress. There is a change this source ip may change on us. */
resource "aws_security_group" "cylance_ingress" {
  name        = "splunk_cylance_ingress"
  description = "cylance_ingress"
  vpc_id      = "${aws_vpc.splunk_vpc.id}"

  tags = "${merge(local.common_tags, map("Name", "splunk_cylance_ingress"))}"

  ingress {
    from_port   = 6514
    to_port     = 6514
    protocol    = "tcp"
    cidr_blocks = "${var.cylance_ingress_hosts}"
    description = "Allows cylance logs from the following: Asia-Pacific Northeast (protect-apne1.cylance.com), Asia-Pacific Northeast (protect-apne1.cylance.com), North America (protect.cylance.com), Europe - Central(protect-euc1.cylance.com)"
  }
}

resource "aws_security_group" "http_forwarder" {
  name        = "http_forwarder"
  description = "http_forwarder"
  vpc_id      = "${aws_vpc.splunk_vpc.id}"

  tags = "${merge(local.common_tags, map("Name", "http_forwarder"))}"

  ingress {
    from_port   = 8088
    to_port     = 8088
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allows "
  }
}

resource "aws_security_group" "splunk_lbs" {
  name        = "splunk_lbs"
  description = "public_splunk_lb_ingress"
  vpc_id      = "${aws_vpc.splunk_vpc.id}"

  tags = "${merge(local.common_tags, map("Name", "public_splunk_lb_ingress"))}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8088
    to_port     = 8088
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allows hf to receive http input"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// phantom

resource "aws_security_group" "phantom_ingress" {
  name        = "phantom_ingress"
  description = "phantom_ingress"
  vpc_id      = "${aws_vpc.splunk_vpc.id}"

  tags = "${merge(local.common_tags, map("Name", "phantom_ingress"))}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.phantom_ingress_hosts}"
    description = "phantom group"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
