resource "aws_vpc_peering_connection" "peering_connection" {
  count = "${var.is_leaf_hub == true ? 1 : 0}"
  peer_owner_id = "${var.account_id}"
  peer_vpc_id   = "${data.terraform_remote_state.corp_vpc.aws_vpc.id}"
  vpc_id        = "${aws_vpc.this.id}"
}
