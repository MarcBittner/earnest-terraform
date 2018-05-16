####################
# Publiс route table
####################
resource "aws_route_table" "public" {

  vpc_id           = "${aws_vpc.this.id}"

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
resource "aws_route_table" "private_a" {
  vpc_id           = "${aws_vpc.this.id}"
}

output "aws_route_table.private_a.id" {
  value = "${aws_route_table.private_a.id}"
}

resource "aws_route_table" "private_b" {
  vpc_id           = "${aws_vpc.this.id}"
}

output "aws_route_table.private_b.id" {
  value = "${aws_route_table.private_b.id}"
}

resource "aws_route_table" "private_c" {
  vpc_id           = "${aws_vpc.this.id}"
}

output "aws_route_table.private_c.id" {
  value = "${aws_route_table.private_c.id}"
}

########################
# Fort Knox route tables
########################
resource "aws_route_table" "fort_knox_a" {
  vpc_id           = "${aws_vpc.this.id}"
}

resource "aws_route_table" "fort_knox_b" {
  vpc_id           = "${aws_vpc.this.id}"
}

resource "aws_route_table" "fort_knox_c" {
  vpc_id           = "${aws_vpc.this.id}"
}

##########################
# Route table association
##########################

#private associations
resource "aws_route_table_association" "private_a" {
  subnet_id      = "${aws_subnet.private_a.id}"
  route_table_id = "${aws_route_table.private_a.id}"
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = "${aws_subnet.private_b.id}"
  route_table_id = "${aws_route_table.private_b.id}"
}

resource "aws_route_table_association" "private_c" {
  subnet_id      = "${aws_subnet.private_c.id}"
  route_table_id = "${aws_route_table.private_c.id}"
}

#public associations
resource "aws_route_table_association" "public_a" {
  subnet_id      = "${aws_subnet.public_a.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = "${aws_subnet.public_b.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "public_c" {
  subnet_id      = "${aws_subnet.public_c.id}"
  route_table_id = "${aws_route_table.public.id}"
}

#fort knox associations
resource "aws_route_table_association" "fort_knox_a" {
  subnet_id      = "${aws_subnet.fort_knox_a.id}"
  route_table_id = "${aws_route_table.fort_knox_a.id}"
}

resource "aws_route_table_association" "fort_knox_b" {
  subnet_id      = "${aws_subnet.fort_knox_b.id}"
  route_table_id = "${aws_route_table.fort_knox_b.id}"
}

resource "aws_route_table_association" "fort_knox_c" {
  subnet_id      = "${aws_subnet.fort_knox_c.id}"
  route_table_id = "${aws_route_table.fort_knox_c.id}"
}


