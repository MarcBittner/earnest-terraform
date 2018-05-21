# variable "environment-region-mapping" {
#   type = "map"

#   default = {
#     "dev"  = "us-east-1"
#     "prod" = "us-east-1"
#   }
# }

variable "vpc-base-cidr" {
  type = "map"

  default = {
    "dev"  = "10.101"
    "prod" = "10.100"
  }
}
