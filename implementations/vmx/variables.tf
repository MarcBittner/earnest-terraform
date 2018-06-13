variable "aws_user_data" {
  type = "map"

  default = {
    dev-us-east-1  = ""
    prod-us-east-1 = ""
    corp-us-east-1 = ""
  }
}
