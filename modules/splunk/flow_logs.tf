resource "aws_flow_log" "flow_log" {
  count          = "${length(var.vpc_ids)}"
  log_group_name = "${aws_cloudwatch_log_group.splunk_cw_log.name}"
  vpc_id         = "${element(var.vpc_ids, count.index)}"
  traffic_type   = "ALL"
  iam_role_arn   = "${aws_iam_role.splunk-role.arn}"
}

resource "aws_cloudwatch_log_group" "splunk_cw_log" {
  name = "ring-sec-splunk-${var.aws_account_name}"
}
