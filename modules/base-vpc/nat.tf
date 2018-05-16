##############
# NAT Gateways
##############
resource "aws_eip" "nat_a" {
  vpc = true
}

resource "aws_eip" "nat_b" {
  vpc = true
}

resource "aws_eip" "nat_c" {
  vpc = true
}

resource "aws_nat_gateway" "a" {
  allocation_id = "${aws_eip.nat_a.id}"
  subnet_id     = "${aws_subnet.public_a.id}"
  depends_on = ["aws_internet_gateway.this"]
}

resource "aws_nat_gateway" "b" {
  allocation_id = "${aws_eip.nat_b.id}"
  subnet_id     = "${aws_subnet.public_b.id}"
  depends_on = ["aws_internet_gateway.this"]
}

resource "aws_nat_gateway" "c" {
  allocation_id = "${aws_eip.nat_c.id}"
  subnet_id     = "${aws_subnet.public_c.id}"
  depends_on = ["aws_internet_gateway.this"]
}

resource "aws_route" "private_nat_a" {
  route_table_id         = "${aws_route_table.private_a.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.a.id}"
}

resource "aws_route" "private_nat_b" {
  route_table_id         = "${aws_route_table.private_b.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.b.id}"
}

resource "aws_route" "private_nat_c" {
  route_table_id         = "${aws_route_table.private_c.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.c.id}"
}


