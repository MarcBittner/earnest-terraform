resource "aws_vpc" "splunk_vpc" {
  cidr_block           = "${var.splunk_vpc_cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = "${merge(local.common_tags, map("Name", "splunk_vpc"))}"

}

resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = "${aws_vpc.splunk_vpc.id}"
  cidr_block              = "${var.splunk_pub_subnet_b_cidr}"
  availability_zone       = "${var.azs[0]}"
  map_public_ip_on_launch = true
  tags                    = "${merge(local.common_tags, map("Name", "splunk_public_subnet_b"), map("type", "ha-pub"))}"
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = "${aws_vpc.splunk_vpc.id}"
  cidr_block              = "${var.splunk_pub_subnet_a_cidr}"
  availability_zone       = "${var.azs[1]}"
  map_public_ip_on_launch = true
  tags                    = "${merge(local.common_tags, map("Name", "splunk_public_subnet_a"), map("type", "ha-pub"))}"

}

resource "aws_subnet" "public_subnet_c" {
  vpc_id                  = "${aws_vpc.splunk_vpc.id}"
  cidr_block              = "${var.splunk_pub_subnet_c_cidr}"
  availability_zone       = "${var.azs[2]}"
  map_public_ip_on_launch = true
  tags                    = "${merge(local.common_tags, map("Name", "splunk_public_subnet_c"), map("type", "ha-pub"))}"

}


resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.splunk_vpc.id}"
  tags   = "${merge(local.common_tags, map("Name", "splunk_internet_gateway"))}"
}

resource "aws_route_table" "public_routetable" {
  vpc_id = "${aws_vpc.splunk_vpc.id}"
  tags   = "${merge(local.common_tags, map("Name", "splunk_route_table"))}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.internet_gateway.id}"
  }
}

resource "aws_route_table_association" "public_subnet_c" {
  subnet_id      = "${aws_subnet.public_subnet_c.id}"
  route_table_id = "${aws_route_table.public_routetable.id}"
}

resource "aws_route_table_association" "public_subnet_b" {
  subnet_id      = "${aws_subnet.public_subnet_b.id}"
  route_table_id = "${aws_route_table.public_routetable.id}"
}

resource "aws_route_table_association" "public_subnet_a" {
  subnet_id      = "${aws_subnet.public_subnet_a.id}"
  route_table_id = "${aws_route_table.public_routetable.id}"
}
