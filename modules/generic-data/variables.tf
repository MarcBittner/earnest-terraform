variable "environment-profile-mapping" {
  type = "map"

  default = {
    "dev"  = "ring-dev"
    "prod" = "ring-prod"
  }
}

variable "environment-region-mapping" {
  type = "map"

  default = {
    "dev"  = "us-east-1"
    "prod" = "us-east-1"
  }
}
