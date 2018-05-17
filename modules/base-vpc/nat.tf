##############
# NAT Gateways
##############
resource "aws_eip" "nat" {
  count = "${var.region-az-count-mapping[var.region]}"
  vpc   = true
}

resource "aws_nat_gateway" "nat_gateway" {
  count = "${var.region-az-count-mapping[var.region]}"

  allocation_id = "${aws_eip.nat.*.id[count.index]}"
  subnet_id     = "${aws_subnet.public.*.id[count.index]}"
  depends_on    = ["aws_internet_gateway.this"]
}

resource "aws_route" "private_nat" {
  route_table_id         = "${aws_route_table.private.*.id[count.index]}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat_gateway.*.id[count.index]}"
}
