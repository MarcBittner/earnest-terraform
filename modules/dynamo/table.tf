locals {
  attributes = [{
    name = "${var.hash_key}"
    type = "S"
  },
    {
      name = "${var.range_key}"
      type = "S"
    },
    "${var.additional_attributes}",
  ]
}

resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "${format("%s-%s", var.name, var.environment)}"
  read_capacity  = "${var.read_capacity}"
  write_capacity = "${var.write_capacity}"
  hash_key       = "${var.hash_key}"
  range_key      = "${var.range_key}"

  attribute = ["${local.attributes}"]

  server_side_encryption {
    enabled = "${var.enable_encryption}"
  }

  ttl {
    attribute_name = "${var.ttl_attribute_name}"
    enabled        = "${var.ttl_enabled}"
  }

  global_secondary_index = ["${var.global_secondary_indexes}"]
  local_secondary_index  = ["${var.local_secondary_indexes}"]

  tags {
    Name        = "${format("%s-%s", var.name, var.environment)}"
    Environment = "${var.environment}"
  }
}
