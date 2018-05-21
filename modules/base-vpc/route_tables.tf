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

####################
# Publiс NAT route table
####################
resource "aws_route_table" "public_nat" {
  vpc_id = "${aws_vpc.this.id}"
}

output "aws_route_table.public_nat.id" {
  value = "${aws_route_table.public_nat.id}"
}

resource "aws_route" "public_nat_internet_gateway" {
  route_table_id         = "${aws_route_table.public_nat.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.this.id}"
}

######################
# Private route table
######################
resource "aws_route_table" "private" {
  count  = "${var.region-az-count-mapping[var.region]}"
  vpc_id = "${aws_vpc.this.id}"
}

output "aws_route_table.private.id" {
  value = ["${aws_route_table.private.*.id}"]
}

######################
# Private ELB route table
######################
resource "aws_route_table" "private_elb" {
  count  = "${var.region-az-count-mapping[var.region]}"
  vpc_id = "${aws_vpc.this.id}"
}

output "aws_route_table.private_elb.id" {
  value = ["${aws_route_table.private_elb.*.id}"]
}

######################
# Private Tooling route table
######################
resource "aws_route_table" "private_tooling" {
  count  = "${var.region-az-count-mapping[var.region]}"
  vpc_id = "${aws_vpc.this.id}"
}

output "aws_route_table.private_tooling.id" {
  value = ["${aws_route_table.private_tooling.*.id}"]
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

# Private associations
resource "aws_route_table_association" "private" {
  count          = "${var.region-az-count-mapping[var.region]}"
  subnet_id      = "${aws_subnet.private.*.id[count.index]}"
  route_table_id = "${aws_route_table.private.*.id[count.index]}"
}

resource "aws_route_table_association" "private_elb" {
  count          = "${var.region-az-count-mapping[var.region]}"
  subnet_id      = "${aws_subnet.private_elb.*.id[count.index]}"
  route_table_id = "${aws_route_table.private_elb.*.id[count.index]}"
}

resource "aws_route_table_association" "private_tooling" {
  count          = "${var.region-az-count-mapping[var.region]}"
  subnet_id      = "${aws_subnet.private_tooling.*.id[count.index]}"
  route_table_id = "${aws_route_table.private_tooling.*.id[count.index]}"
}

# Public associations
resource "aws_route_table_association" "public" {
  count = "${var.region-az-count-mapping[var.region]}"

  subnet_id      = "${aws_subnet.public.*.id[count.index]}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "public_nat" {
  count = "${var.region-az-count-mapping[var.region]}"

  subnet_id      = "${aws_subnet.public_nat.*.id[count.index]}"
  route_table_id = "${aws_route_table.public_nat.id}"
}

# Fort knox associations
resource "aws_route_table_association" "fortknox" {
  count = "${var.region-az-count-mapping[var.region]}"

  subnet_id      = "${aws_subnet.fortknox.*.id[count.index]}"
  route_table_id = "${aws_route_table.fortknox.id}"
}
