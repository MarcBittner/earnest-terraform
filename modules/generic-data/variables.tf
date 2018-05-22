variable "environment-profile-mapping" {
  type = "map"

  default = {
    "dev"  = "dev-ring"
    "qa"   = "qa-ring"
    "prod" = "prod-ring"
  }
}

variable "environment-region-mapping" {
  type = "map"

  default = {
    "dev"  = "us-east-1"
    "qa"   = "us-east-1"
    "prod" = "us-east-1"
  }
}

variable "environment-short-to-long-name-mapping" {
  type = "map"

  default = {
    "dev"  = "development"
    "qa"   = "qa"
    "prod" = "production"
  }
}
