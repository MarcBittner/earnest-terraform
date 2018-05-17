resource "aws_dynamodb_table" "ring-terraform_lock_table-practice" {
  provider       = "aws.dev"
  name           = "ring-terraform_lock_table-practice"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
