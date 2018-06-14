resource "aws_vpc_peering_connection" "peering_connection" {
  count         = "${var.is_leaf_hub == true ? 1 : 0}"
  peer_owner_id = "${var.account_id}"
  peer_vpc_id   = "${data.terraform_remote_state.corp_vpc.aws_vpc.id}"
  vpc_id        = "${aws_vpc.this.id}"
  auto_accept   = false
  peer_owner_id = "774154506888"
  peer_region   = "us-east-1"
}

resource "aws_vpc_peering_connection_accepter" "peer" {
  count         = "${var.is_leaf_hub == true ? 1 : 0}"
 
  provider                  = "aws.corp"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peering_connection.id}"
  auto_accept               = true

  tags {
    Side = "Accepter"
  }
}

#############################################
# Local Routes
#############################################

resource "aws_route" "public_local_to_hub" {
  count = "${var.is_leaf_hub == true ? 1 : 0}"

  route_table_id            = "${aws_route_table.public_nat.id}"
  destination_cidr_block    = "${data.terraform_remote_state.corp_vpc.cidr}.0.0/16"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peering_connection.id}"
}

resource "aws_route" "private_nat_local" {
  count = "${var.is_leaf_hub == true ? var.region-az-count-mapping[var.region] : 0}"

  route_table_id            = "${aws_route_table.private.*.id[count.index]}"
  destination_cidr_block    = "${data.terraform_remote_state.corp_vpc.cidr}.0.0/16"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peering_connection.id}"
}

#############################################
# Hub Routes
#############################################

resource "aws_route" "public_hub_to_local" {
  provider = "aws.corp"
  count    = "${var.is_leaf_hub == true ? 1 : 0}"

  route_table_id            = "${data.terraform_remote_state.corp_vpc.aws_route_table.public_nat.id}"
  destination_cidr_block    = "${var.cidr_base}.0.0/16"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peering_connection.id}"
}

resource "aws_route" "private_nat_hub" {
  provider = "aws.corp"
  count = "${var.is_leaf_hub == true ? var.region-az-count-mapping[var.region] : 0}"

  route_table_id            = "${data.terraform_remote_state.corp_vpc.aws_route_table.private.ids[count.index]}"
  destination_cidr_block    = "${var.cidr_base}.0.0/16"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peering_connection.id}"
}
