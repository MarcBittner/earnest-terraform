####################
# Publiс route table
####################
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.this.id}"
}

output "aws_route_table.public.id" {
  value = "${aws_route_table.public.id}"
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.this.id}"
}

######################
# Private route tables
######################
resource "aws_route_table" "private" {
  count  = "${var.region-az-count-mapping[var.region]}"
  vpc_id = "${aws_vpc.this.id}"
}

output "aws_route_table.private.id" {
  value = ["${aws_route_table.private.*.id}"]
}

########################
# Fort Knox route tables
########################

resource "aws_route_table" "fortknox" {
  vpc_id = "${aws_vpc.this.id}"
}

output "aws_route_table.fortknox.id" {
  value = "${aws_route_table.fortknox.id}"
}

##########################
# Route table association
##########################
#private associations
resource "aws_route_table_association" "private" {
  count          = "${var.region-az-count-mapping[var.region]}"
  subnet_id      = "${aws_subnet.private.*.id[count.index]}"
  route_table_id = "${aws_route_table.private.*.id[count.index]}"
}

#public associations
resource "aws_route_table_association" "public" {
  count = "${var.region-az-count-mapping[var.region]}"

  subnet_id      = "${aws_subnet.public.*.id[count.index]}"
  route_table_id = "${aws_route_table.public.id}"
}

#fort knox associations
resource "aws_route_table_association" "fortknox" {
  count = "${var.region-az-count-mapping[var.region]}"

  subnet_id      = "${aws_subnet.fortknox.*.id[count.index]}"
  route_table_id = "${aws_route_table.fortknox.id}"
}
