###########################################################################
#allow all ingress security group
resource "aws_security_group" "allow_all" {
  name        = "${terraform.workspace}-allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.this.id}"

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#OUTPUTS
output "aws_security_group.allow_all.id" {
  value = "${aws_security_group.allow_all.id}"
}

###########################################################################
#allow all within vpc
resource "aws_security_group" "allow_all_within_vpc" {
  name        = "${terraform.workspace}-allow_all_within_vpc"
  description = "Allow all inbound traffic within vpc"
  vpc_id      = "${aws_vpc.this.id}"

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["${aws_vpc.this.cidr_block}"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["${aws_vpc.this.cidr_block}"]
  }
}

#OUTPUTS
output "aws_security_group.allow_all_within_vpc.id" {
  value = "${aws_security_group.allow_all_within_vpc.id}"
}

###########################################################################
#allow all from cloud cidrs
resource "aws_security_group" "allow_all_within_cloud" {
  name        = "${terraform.workspace}-allow_all_within_cloud"
  description = "Allow all inbound traffic from all ring cloud cidrs"
  vpc_id      = "${aws_vpc.this.id}"

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["${compact(distinct(concat(list(aws_vpc.this.cidr_block), var.external-allow-all-cidrs)))}"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["${compact(distinct(concat(list(aws_vpc.this.cidr_block), var.external-allow-all-cidrs)))}"]
  }
}

#OUTPUTS
output "aws_security_group.allow_all_within_cloud.id" {
  value = "${aws_security_group.allow_all_within_cloud.id}"
}

#########################################################################
resource "aws_security_group" "qualys_sg" {
  name   = "qualys-sg"
  vpc_id = "${aws_vpc.this.id}"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "aws_security_group.qualys_sg.id" {
  value = "${aws_security_group.qualys_sg.id}"
}

#######################################################################
resource "aws_security_group" "ring_jumphost_sg" {
  name   = "ring-jumphost"
  vpc_id = "${aws_vpc.this.id}"

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = ["${aws_security_group.qualys_sg.id}"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "aws_security_group.ring_jumphost_sg.id" {
  value = "${aws_security_group.ring_jumphost_sg.id}"
}
