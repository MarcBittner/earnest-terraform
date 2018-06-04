locals {
  attributes = [
    {
      name = "${var.hash_key}"
      type = "${var.hash_key_type}"
    },
    {
      name = "${var.range_key}"
      type = "${var.range_key_type}"
    },
    "${var.additional_attributes}",
  ]

  tags = "${merge(
    map(
    "Name", "${format("%s-%s", var.name, var.environment)}",
    "Environment", "${var.environment}"
    ),
    "${var.tags}"
  )}"
}

resource "aws_dynamodb_table" "this" {
  name           = "${format("%s-%s", var.name, var.environment)}"
  read_capacity  = "${var.read_capacity}"
  write_capacity = "${var.write_capacity}"
  hash_key       = "${var.hash_key}"
  range_key      = "${var.range_key}"

  attribute = ["${local.attributes}"]

  server_side_encryption {
    enabled = "${var.enable_encryption}"
  }

  point_in_time_recovery {
    enabled = "${var.enable_backups}"
  }

  ttl {
    attribute_name = "${var.ttl_attribute_name}"
    enabled        = "${var.ttl_enabled}"
  }

  global_secondary_index = ["${var.global_secondary_indexes}"]
  local_secondary_index  = ["${var.local_secondary_indexes}"]

  tags = "${local.tags}"
}
