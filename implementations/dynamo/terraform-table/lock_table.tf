resource "aws_dynamodb_table" "ring-terraform_lock_table" {
  provider       = "aws.ring-it"
  name           = "ring-terraform_lock_table"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
