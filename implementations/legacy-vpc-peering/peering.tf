#############################################
# OLD PROD Peering + Routes
#############################################



resource "aws_vpc_peering_connection" "old_prod_peering_connection" {
  provider = "aws.corp"

  peer_vpc_id   = "vpc-65835100"
  vpc_id        = "${data.terraform_remote_state.corp_vpc.aws_vpc.id}"
  auto_accept   = false
  peer_owner_id = "890452240102"
  peer_region   = "us-east-1"
}

resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = "aws.old-prod"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.old_prod_peering_connection.id}"
  auto_accept               = true

  tags {
    Side = "Accepter"
  }
}

#############################################
# Old-prod Routes
#############################################

resource "aws_route" "old-prod_public" {
  provider = "aws.old-prod"
  count = "${length(var.old-prod-public-route-tables)}"

  route_table_id            = "${var.old-prod-public-route-tables[count.index]}"
  destination_cidr_block    = "${data.terraform_remote_state.corp_vpc.cidr}.0.0/16"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.old_prod_peering_connection.id}"
}

resource "aws_route" "old-prod_private" {
  provider = "aws.old-prod"
  count = "${length(var.old-prod-private-route-tables)}"

  route_table_id            = "${var.old-prod-private-route-tables[count.index]}"
  destination_cidr_block    = "${data.terraform_remote_state.corp_vpc.cidr}.0.0/16"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.old_prod_peering_connection.id}"
}

#############################################
# Hub Routes
#############################################

resource "aws_route" "corp_public" {
  provider = "aws.corp"

  route_table_id            = "${data.terraform_remote_state.corp_vpc.aws_route_table.public.id}"
  destination_cidr_block    = "${var.old-prod-cidr}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.old_prod_peering_connection.id}"
}

resource "aws_route" "corp_private" {
  provider = "aws.corp"
  count = "${length(data.terraform_remote_state.corp_vpc.aws_route_table.private.ids)}"

  route_table_id            = "${data.terraform_remote_state.corp_vpc.aws_route_table.private.ids[count.index]}"
  destination_cidr_block    = "${var.old-prod-cidr}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.old_prod_peering_connection.id}"
}
