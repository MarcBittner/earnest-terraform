######
# VPC
######
resource "aws_vpc" "this" {
  cidr_block           = "${var.cidr_base}.0.0/16"
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"

  tags {
    Name = "${var.name}"
  }
}

#Outputs
output "vpc.id" {
  value = "${aws_vpc.this.id}"
}

######################
# VPC Endpoint for S3
######################
data "aws_vpc_endpoint_service" "s3" {
  service = "s3"
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = "${aws_vpc.this.id}"
  service_name = "${data.aws_vpc_endpoint_service.s3.service_name}"
}

#private associations
resource "aws_vpc_endpoint_route_table_association" "private" {
  count = "${var.region-az-count-mapping[var.region]}"

  vpc_endpoint_id = "${aws_vpc_endpoint.s3.id}"
  route_table_id  = "${aws_route_table.private.*.id[count.index]}"
}

#public associations
resource "aws_vpc_endpoint_route_table_association" "public" {
  vpc_endpoint_id = "${aws_vpc_endpoint.s3.id}"
  route_table_id  = "${aws_route_table.public.id}"
}

#fort knox associations
resource "aws_vpc_endpoint_route_table_association" "fortknox" {
  vpc_endpoint_id = "${aws_vpc_endpoint.s3.id}"
  route_table_id  = "${aws_route_table.fortknox.id}"
}
