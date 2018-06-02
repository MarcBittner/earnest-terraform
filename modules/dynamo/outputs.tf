output "table_arn" {
  value = "${aws_dynamodb_table.this.arn}"
}

output "table_id" {
  value = "${aws_dynamodb_table.this.id}"
}
